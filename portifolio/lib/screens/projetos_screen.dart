import 'package:flutter/material.dart';
import '../components/project_card.dart';

class ProjetosScreen extends StatefulWidget {
  @override
  _ProjetosScreenState createState() => _ProjetosScreenState();
}

class _ProjetosScreenState extends State<ProjetosScreen> {
  List<Map<String, dynamic>> projetos = [
    {'nome': 'TCC', 'imagem': 'assets/images/tcc.png', 'curtido': false},
    {
      'nome': 'Servidor de Filmes',
      'imagem': 'assets/images/filmes.png',
      'curtido': false,
    },
    {
      'nome': 'Site para Crianças',
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
      appBar: AppBar(
        title: Text('Meus Projetos', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0A1F44),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: ListView.builder(
        padding: EdgeInsets.all(10),
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
