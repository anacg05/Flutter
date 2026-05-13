import 'package:app_energy_monster/controllers/favorites_controller.dart';
import 'package:flutter/material.dart';
import '../models/monster.dart';
import '../theme/colors.dart';

class DetailsScreen extends StatelessWidget {
  final Monster monster;

  // Passagem de objeto via construtor
  const DetailsScreen({super.key, required this.monster});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Color(int.parse(monster.hexColor));

    return Scaffold(
      backgroundColor: MonsterColors.backgroundBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: accentColor),
        title: Text(monster.nome, style: TextStyle(color: accentColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Imagem com efeito de sombra neon
            Center(
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withOpacity(0.3),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: Image.network(monster.imagemUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SOBRE O SABOR",
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    monster.descricao,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Botão de Favorito
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        await FavoritesController().toggleFavorite(monster.id);

                        // Feedback visual para o usuário
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${monster.nome} atualizado nos favoritos!",
                            ),
                            backgroundColor: accentColor,
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.favorite_border),
                      label: const Text(
                        "ADICIONAR AOS FAVORITOS",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
