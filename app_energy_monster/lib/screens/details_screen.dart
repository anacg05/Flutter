import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/monster_model.dart';
import '../theme/colors.dart';
import '../controllers/favorites_controller.dart';

class DetailsScreen extends StatelessWidget {
  final Monster monster;

  const DetailsScreen({super.key, required this.monster});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Color(int.parse(monster.hexColor));

    return Scaffold(
      backgroundColor: MonsterColors.backgroundBlack,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
          shadows: [Shadow(color: accentColor, blurRadius: 10)],
        ),
        actions: [
          Consumer<FavoritesController>(
            builder: (context, favController, child) {
              final isFav = favController.isFavorite(monster.id);
              return IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                color: isFav ? accentColor : Colors.white,
                onPressed: () => favController.toggleFavorite(monster.id),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      // O Stack agora contém apenas o conteúdo principal
      body: Stack(
        children: [
          // --- O Positioned que criava o círculo de fundo FOI REMOVIDO DAQUI ---
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ), // Ajustado para compensar a remoção do Positioned
                // ÁREA DA IMAGEM COM O BRILHO NEON (Mantido)
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Aura de luz atrás da lata
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withOpacity(0.4),
                              blurRadius: 100,
                              spreadRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      // A LATA COM ANIMAÇÃO HERO (Mantido)
                      Hero(
                        tag: monster.id,
                        child: Container(
                          height: 400,
                          child: monster.imagemUrl.startsWith('assets')
                              ? Image.asset(
                                  monster.imagemUrl,
                                  fit: BoxFit.contain,
                                )
                              : Image.network(
                                  monster.imagemUrl,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.local_drink,
                                        size: 100,
                                        color: Colors.white,
                                      ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                // CARD DE INFORMAÇÕES ESTILIZADO (Mantido)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: MonsterColors.cardGrey.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withOpacity(0.1),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              monster.nome.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 28,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          Text(
                            "R\$ 12,90",
                            style: TextStyle(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              shadows: [
                                Shadow(color: accentColor, blurRadius: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Energy Drink - 473ml",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Divider(color: Colors.white.withOpacity(0.1)),
                      const SizedBox(height: 20),
                      Text(
                        "SOBRE O SABOR",
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        monster.descricao,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // BOTÃO DE COMPRA ESTILO E-COMMERCE (Mantido)
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            foregroundColor: Colors.black,
                            elevation: 10,
                            shadowColor: accentColor.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Adicionado ao Carrinho!"),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_checkout,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(width: 15),
                              Text(
                                "COMPRAR AGORA",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
