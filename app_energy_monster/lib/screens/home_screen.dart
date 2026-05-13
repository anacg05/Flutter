import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/monster.dart';
import '../services/monster_service.dart';
import 'details_screen.dart';
import 'admin_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MonsterColors.backgroundBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "MONSTER ZONE",
          style: TextStyle(
            color: MonsterColors.neonGreen,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      
      // Ações do usuário
      floatingActionButton: FloatingActionButton(
        backgroundColor: MonsterColors.neonGreen,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AdminScreen()),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "DESCUBRA SEU PRÓXIMO GOLE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // integração aos serviços web (GET)
            Expanded(
              child: FutureBuilder<List<Monster>>(
                future: MonsterService().fetchMonsters(), 
                builder: (context, snapshot) {
                  
                  // Tratamento de estados da conexão
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: MonsterColors.neonGreen,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Erro ao carregar os dados da API",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        "Nenhum energético encontrado.",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  final monsters = snapshot.data!;

                  // Manipulação de listas na interface
                  return ListView.builder(
                    itemCount: monsters.length,
                    itemBuilder: (context, index) {
                      final monster = monsters[index];

                      // Converte a String hexColor da API para Color
                      final Color cardColor = Color(
                        int.parse(monster.hexColor),
                      );

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: MonsterColors.cardGrey,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: cardColor.withOpacity(0.5)),
                          boxShadow: [
                            BoxShadow(
                              color: cardColor.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Hero(
                            tag: monster.id,
                            child: Image.network(
                              monster.imagemUrl,
                              width: 40,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.local_drink, color: Colors.white),
                            ),
                          ),
                          title: Text(
                            monster.nome,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            monster.descricao,
                            style: const TextStyle(color: Colors.grey, fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: cardColor,
                            size: 14,
                          ),
                          onTap: () {
                            // Navegação e Passagem de parâmetros
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  monster: monster,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}