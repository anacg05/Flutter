import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/colors.dart';
import '../models/monster_model.dart';
import '../services/monster_service.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/cart_controller.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryNeon = MonsterColors.mangoLoco;

    return Scaffold(
      backgroundColor: MonsterColors.backgroundBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: GestureDetector(
          child: const Text(
            "MEUS FAVORITOS",
            style: TextStyle(
              color: primaryNeon,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              shadows: [
                Shadow(
                  color: primaryNeon,
                  blurRadius: 15,
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Monster>>(
        future: MonsterService().fetchMonsters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryNeon),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Erro na conexão...",
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          final allMonsters = snapshot.data ?? [];
          
          return Consumer<FavoritesController>(
            builder: (context, favController, child) {
              final favoriteMonsters = allMonsters
                  .where((m) => favController.isFavorite(m.id))
                  .toList();

              if (favoriteMonsters.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 80,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "NENHUM FAVORITO ADICIONADO",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: favoriteMonsters.length,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final monster = favoriteMonsters[index];
                  final Color cardColor = Color(int.parse(monster.hexColor));

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(monster: monster),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      height: 155,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            MonsterColors.cardGrey,
                            cardColor.withOpacity(0.2),
                          ],
                          begin: Alignment.topLeft,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: cardColor,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: cardColor.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Hero(
                            tag: monster.id,
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: cardColor.withOpacity(0.3),
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                monster.imagemUrl,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        monster.nome.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 17,
                                          shadows: [Shadow(color: cardColor, blurRadius: 10)],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        monster.descricao,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 13,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: cardColor.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: cardColor.withOpacity(0.6), width: 1.5),
                                    ),
                                    child: Text(
                                      "R\$ 12,90",
                                      style: TextStyle(
                                        color: cardColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: cardColor,
                                  size: 28,
                                ),
                                onPressed: () => favController.toggleFavorite(monster.id),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Provider.of<CartController>(context, listen: false)
                                      .adicionarAoCarrinho(monster);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "${monster.nome.toUpperCase()} ADICIONADO AO CARRINHO!",
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor: cardColor,
                                      duration: const Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: primaryNeon,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primaryNeon.withOpacity(0.4),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.black,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}