import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/colors.dart';
import '../models/monster_model.dart';
import '../services/monster_service.dart';
import '../controllers/favorites_controller.dart';
import 'details_screen.dart';
import 'admin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variável para controlar o filtro selecionado
  String selectedCategory = "TODOS";

  @override
  Widget build(BuildContext context) {
    const Color primaryNeon = MonsterColors.mangoLoco;

    return Scaffold(
      backgroundColor: MonsterColors.backgroundBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.person_outline,
          color: Colors.white,
          size: 30,
        ),
        title: Text(
          "MONSTER STORE",
          style: TextStyle(
            color: primaryNeon,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            shadows: [
              Shadow(color: primaryNeon.withOpacity(0.9), blurRadius: 15),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),

      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primaryNeon.withOpacity(0.5),
              blurRadius: 25,
              spreadRadius: 2,
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: primaryNeon,
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.black, size: 35),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminScreen()),
          ),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner de Promoção
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryNeon.withOpacity(0.5)),
                gradient: LinearGradient(
                  colors: [primaryNeon.withOpacity(0.2), Colors.transparent],
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.flash_on, color: primaryNeon),
                  SizedBox(width: 15),
                  Text(
                    "LEVE 3, PAGUE 2",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // SEÇÃO DE FILTROS (CATEGORIAS)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildFilterChip("TODOS", primaryNeon),
                  _buildFilterChip("ULTRA", Colors.white),
                  _buildFilterChip("JUICE", Colors.orange),
                  _buildFilterChip("JAVA", Colors.brown),
                  _buildFilterChip("PUNCH", Colors.red),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: FutureBuilder<List<Monster>>(
              future: MonsterService().fetchMonsters(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: primaryNeon),
                  );
                }

                // LÓGICA DE FILTRAGEM
                List<Monster> allMonsters = snapshot.data ?? [];
                List<Monster> filteredMonsters = selectedCategory == "TODOS"
                    ? allMonsters
                    : allMonsters
                          .where(
                            (m) =>
                                m.nome.toUpperCase().contains(selectedCategory),
                          )
                          .toList();

                return ListView.builder(
                  itemCount: filteredMonsters.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final monster = filteredMonsters[index];
                    final Color cardColor = Color(int.parse(monster.hexColor));

                    return Consumer<FavoritesController>(
                      builder: (context, favController, child) {
                        final bool isFavorite = favController.isFavorite(
                          monster.id,
                        );

                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsScreen(monster: monster),
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
                                color: isFavorite
                                    ? cardColor
                                    : cardColor.withOpacity(0.3),
                                width: isFavorite ? 3 : 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: cardColor.withOpacity(
                                    isFavorite ? 0.4 : 0.15,
                                  ),
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
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Image.asset(
                                      monster.imagemUrl,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          monster.nome.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 17,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: cardColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: cardColor.withOpacity(0.5),
                                            ),
                                          ),
                                          child: Text(
                                            "R\$ 12,90",
                                            style: TextStyle(
                                              color: cardColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite
                                            ? cardColor
                                            : Colors.white24,
                                      ),
                                      onPressed: () => favController
                                          .toggleFavorite(monster.id),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: primaryNeon,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.black,
                                          size: 22,
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
          ),
        ],
      ),
    );
  }

  // Widget de filtro que atualiza o estado
  Widget _buildFilterChip(String label, Color color) {
    bool isSelected = selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : MonsterColors.cardGrey,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? color : Colors.white.withOpacity(0.1),
            width: 2,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10)]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? color : Colors.white.withOpacity(0.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
