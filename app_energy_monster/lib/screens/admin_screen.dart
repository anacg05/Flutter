import 'package:flutter/material.dart';
import '../models/monster_model.dart';
import '../services/monster_service.dart';
import '../theme/colors.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _nomeController = TextEditingController();
  final _descController = TextEditingController();

  final Color primaryNeon = MonsterColors.mangoLoco;

  void _salvarMonster() async {
    if (_nomeController.text.isEmpty || _descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos!")),
      );
      return;
    }

    final novoMonster = Monster(
      id: DateTime.now().toString(),
      nome: _nomeController.text,
      descricao: _descController.text,
      imagemUrl:
          "https://vignette.wikia.nocookie.net/monsterenergy/images/b/b3/Monster_Energy_Logo.png",
      hexColor: "0xFF41C1F3",
    );

    final sucesso = await MonsterService().addMonster(novoMonster);

    if (sucesso && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "PRODUTO LANÇADO NO SISTEMA!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: primaryNeon,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MonsterColors.backgroundBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "GESTÃO DE ESTOQUE",
          style: TextStyle(
            color: primaryNeon,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            shadows: [
              Shadow(color: primaryNeon.withOpacity(0.5), blurRadius: 10),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Icon(
              Icons.add_business_rounded,
              size: 80,
              color: primaryNeon.withOpacity(0.8),
            ),
            const SizedBox(height: 10),
            const Text(
              "ADICIONAR NOVO MONSTER",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: MonsterColors.cardGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: primaryNeon.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: primaryNeon.withOpacity(0.05),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _nomeController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "NOME DO ENERGÉTICO",
                      labelStyle: TextStyle(
                        color: primaryNeon.withOpacity(0.7),
                      ),
                      prefixIcon: Icon(Icons.abc, color: primaryNeon),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: primaryNeon),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  TextField(
                    controller: _descController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "DESCRIÇÃO DO SABOR",
                      labelStyle: TextStyle(
                        color: primaryNeon.withOpacity(0.7),
                      ),
                      prefixIcon: Icon(
                        Icons.description_outlined,
                        color: primaryNeon,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: primaryNeon),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: primaryNeon.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _salvarMonster,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryNeon,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "FINALIZAR CADASTRO",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
