import 'package:app_energy_monster/screens/cart_screen.dart';
import 'package:app_energy_monster/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/colors.dart';
import '../models/monster_model.dart';
import '../services/monster_service.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/cart_controller.dart';
import '../components/category_card.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "TODOS";
  bool _verApenasFavoritos = false;

  void _confirmarExclusao(
    BuildContext context,
    Monster monster,
    Color themeColor,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: MonsterColors.cardGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: themeColor.withOpacity(0.5), width: 1.5),
          ),
          title: Text(
            "REMOVER DO ESTOQUE?",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: 1,
              shadows: [
                Shadow(color: themeColor.withOpacity(0.5), blurRadius: 10),
              ],
            ),
          ),
          content: Text(
            "Deseja deletar permanentemente o ${monster.nome.toUpperCase()} do catálogo do sistema?",
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                "CANCELAR",
                style: TextStyle(
                  color: Colors.white38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);

                final sucesso = await MonsterService().deleteMonster(
                  monster.id,
                );

                if (sucesso && mounted) {
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${monster.nome.toUpperCase()} REMOVIDO COM SUCESSO!",
                      ),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Erro ao remover o produto da API."),
                      backgroundColor: Colors.orange,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text(
                "DELETAR",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _resetarHome() {
    setState(() {
      selectedCategory = "TODOS";
      _verApenasFavoritos = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryNeon = MonsterColors.mangoLoco;

    return Scaffold(
      backgroundColor: MonsterColors.backgroundBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FavoritesScreen()),
          ),
        ),
        title: GestureDetector(
          onTap: _resetarHome,
          child: Text(
            "MONSTER STORE",
            style: const TextStyle(
              color: primaryNeon,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              shadows: [Shadow(color: primaryNeon, blurRadius: 15)],
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Consumer<CartController>(
              builder: (context, cartController, child) {
                final totalItens = cartController.quantidadeTotal;
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      if (totalItens > 0)
                        Positioned(
                          right: 0,
                          top: 12,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: primaryNeon,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              "$totalItens",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  CategoryCard(
                    title: "TODOS",
                    icon: Icons.clear_all_rounded,
                    accentColor: primaryNeon,
                    isSelected: selectedCategory == "TODOS",
                    onTap: () => setState(() => selectedCategory = "TODOS"),
                  ),
                  const SizedBox(width: 12),
                  CategoryCard(
                    title: "ULTRA",
                    icon: Icons.bolt,
                    accentColor: Colors.white,
                    isSelected: selectedCategory == "ULTRA",
                    onTap: () => setState(() => selectedCategory = "ULTRA"),
                  ),
                  const SizedBox(width: 12),
                  CategoryCard(
                    title: "ZERO",
                    icon: Icons.do_not_disturb_on_total_silence,
                    accentColor: Colors.cyanAccent,
                    isSelected: selectedCategory == "ZERO",
                    onTap: () => setState(() => selectedCategory = "ZERO"),
                  ),
                  const SizedBox(width: 12),
                  CategoryCard(
                    title: "ENERGY",
                    icon: Icons.flash_on,
                    accentColor: Colors.yellow,
                    isSelected: selectedCategory == "ENERGY",
                    onTap: () => setState(() => selectedCategory = "ENERGY"),
                  ),
                  const SizedBox(width: 12),
                  CategoryCard(
                    title: "JUICE",
                    icon: Icons.local_drink_rounded,
                    accentColor: Colors.orange,
                    isSelected: selectedCategory == "JUICE",
                    onTap: () => setState(() => selectedCategory = "JUICE"),
                  ),
                  const SizedBox(width: 12),
                  CategoryCard(
                    title: "PUNCH",
                    icon: Icons.blender,
                    accentColor: Colors.red,
                    isSelected: selectedCategory == "PUNCH",
                    onTap: () => setState(() => selectedCategory = "PUNCH"),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          Expanded(
            child: FutureBuilder<List<Monster>>(
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

                List<Monster> monsters = snapshot.data ?? [];
                final favController = Provider.of<FavoritesController>(
                  context,
                  listen: false,
                );

                if (_verApenasFavoritos) {
                  monsters = monsters
                      .where((m) => favController.isFavorite(m.id))
                      .toList();
                }

                List<Monster> filteredMonsters = selectedCategory == "TODOS"
                    ? monsters
                    : monsters.where((m) {
                        final nomeMaiusculo = m.nome.toUpperCase();

                        if (selectedCategory == "ULTRA") {
                          return m is MonsterUltra ||
                              nomeMaiusculo.contains("ULTRA") ||
                              nomeMaiusculo.contains("WHITE") ||
                              nomeMaiusculo.contains("VIOLET") ||
                              nomeMaiusculo.contains("WATERMELON") ||
                              nomeMaiusculo.contains("PEACH") ||
                              nomeMaiusculo.contains("FIESTA") ||
                              nomeMaiusculo.contains("STRAWBERRY");
                        }

                        if (selectedCategory == "ZERO") {
                          return m is MonsterUltra ||
                              nomeMaiusculo.contains("ZERO") ||
                              nomeMaiusculo.contains("WHITE") ||
                              nomeMaiusculo.contains("VIOLET") ||
                              nomeMaiusculo.contains("WATERMELON") ||
                              nomeMaiusculo.contains("PEACH") ||
                              nomeMaiusculo.contains("FIESTA") ||
                              nomeMaiusculo.contains("PARADISE") ||
                              nomeMaiusculo.contains("STRAWBERRY");
                        }

                        if (selectedCategory == "ENERGY") {
                          return nomeMaiusculo.contains("ORIGINAL") ||
                              nomeMaiusculo.contains("ABSOLUTELY ZERO");
                        }

                        if (selectedCategory == "JUICE") {
                          return m is MonsterJuice ||
                              nomeMaiusculo.contains("PACIFIC PUNCH") ||
                              nomeMaiusculo.contains("MANGO LOCO") ||
                              nomeMaiusculo.contains("KHAOTIC") ||
                              nomeMaiusculo.contains("PIPELINE") ||
                              nomeMaiusculo.contains("RIO PUNCH") ||
                              nomeMaiusculo.contains("FIESTA MANGO") ||
                              nomeMaiusculo.contains("JUICE");
                        }

                        if (selectedCategory == "PUNCH") {
                          return nomeMaiusculo.contains("PUNCH");
                        }

                        return nomeMaiusculo.contains(selectedCategory);
                      }).toList();

                if (filteredMonsters.isEmpty) {
                  return Center(
                    child: Text(
                      _verApenasFavoritos
                          ? "Nenhum favorito nesta categoria."
                          : "Nenhum energético encontrado.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

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
                          onLongPress: () =>
                              _confirmarExclusao(context, monster, cardColor),
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
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              monster.nome.toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 17,
                                                shadows: [
                                                  Shadow(
                                                    color: cardColor,
                                                    blurRadius: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              monster.descricao,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(
                                                  0.8,
                                                ),
                                                fontSize: 13,
                                                height: 1.3,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: cardColor.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: cardColor.withOpacity(0.6),
                                              width: 1.5,
                                            ),
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
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        favController.toggleFavorite(
                                          monster.id,
                                        );
                                        if (_verApenasFavoritos) {
                                          setState(() {});
                                        }
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<CartController>(
                                          context,
                                          listen: false,
                                        ).adicionarAoCarrinho(monster);

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "${monster.nome.toUpperCase()} ADICIONADO AO CARRINHO!",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            backgroundColor: cardColor,
                                            duration: const Duration(
                                              seconds: 1,
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 12,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: primaryNeon,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: primaryNeon.withOpacity(
                                                  0.4,
                                                ),
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
          ),
        ],
      ),
    );
  }
}
