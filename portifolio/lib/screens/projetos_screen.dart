import 'package:flutter/material.dart';
import '../components/project_card.dart';

class ProjetosScreen extends StatefulWidget {
  const ProjetosScreen({super.key});

  @override
  State<ProjetosScreen> createState() => _ProjetosScreenState();
}

class _ProjetosScreenState extends State<ProjetosScreen> {
  static const Color primaryBlue = Color(0xFF0A1F44);
  static const Color accentBlue = Color(0xFF1A3A77);

  final List<Map<String, dynamic>> projetos = [
    {'nome': 'TCC MELIA', 'imagem': 'assets/images/tcc.png', 'curtido': false},
    {
      'nome': 'GrizFlix',
      'imagem': 'assets/images/filmes.png',
      'curtido': false,
    },
    {
      'nome': 'Bem-vindo, Pequeno Leitor',
      'imagem': 'assets/images/alice.png',
      'curtido': false,
    },
  ];

  void toggleLike(int index) {
    setState(() {
      projetos[index]['curtido'] = !projetos[index]['curtido'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          'Meus Projetos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false, 
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryBlue, accentBlue],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: projetos.length,
        itemBuilder: (context, index) {
          final projeto = projetos[index];
          return ProjectCard(
            nome: projeto['nome'],
            imagem: projeto['imagem'],
            curtido: projeto['curtido'],
            onLike: () => toggleLike(index),
          );
        },
      ),
    );
  }
}
