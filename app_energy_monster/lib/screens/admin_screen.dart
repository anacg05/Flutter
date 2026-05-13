import 'package:flutter/material.dart';
import '../models/monster.dart';
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

  void _salvarMonster() async {
    final novoMonster = Monster(
      id: DateTime.now().toString(),
      nome: _nomeController.text,
      descricao: _descController.text,
      imagemUrl: "https://vignette.wikia.nocookie.net/monsterenergy/images/b/b3/Monster_Energy_Logo.png",
      hexColor: "0xFF8DFD0E", 
    );

    final sucesso = await MonsterService().addMonster(novoMonster);

    if (sucesso && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Monster adicionado com sucesso! (POST)")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MonsterColors.backgroundBlack,
      appBar: AppBar(title: const Text("NOVO PRODUTO"), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Nome do Energético",
                labelStyle: TextStyle(color: MonsterColors.neonGreen),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Descrição/Sabor",
                labelStyle: TextStyle(color: MonsterColors.neonGreen),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _salvarMonster,
              style: ElevatedButton.styleFrom(backgroundColor: MonsterColors.neonGreen),
              child: const Text("CADASTRAR (POST)", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}