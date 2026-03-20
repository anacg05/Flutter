import 'package:flutter/material.dart';

class ProjetosScreen extends StatefulWidget {
  @override
  _ProjetosScreenState createState() => _ProjetosScreenState();
}

class _ProjetosScreenState extends State<ProjetosScreen> {
  List<Map<String, dynamic>> projetos = [
    {
      'nome': 'Servidor de Filmes',
      'imagem': 'assets/images/filmes.png',
      'curtido': false,
    },
    {
      'nome': 'TCC',
      'imagem': 'assets/images/tcc.png', 
      'curtido': false
    },
    {
      'nome': 'Leitura para Crianças',
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
        title: Text('Projetos'),
        backgroundColor: Color(0xFF0A1F44),
      ),
      body: ListView.builder(
        itemCount: projetos.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                // IMAGEM
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.asset(
                    projetos[index]['imagem'],
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                //TEXTO + LIKE
                ListTile(
                  title: Text(projetos[index]['nome']),
                  trailing: IconButton(
                    icon: Icon(
                      projetos[index]['curtido']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: projetos[index]['curtido']
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () => toggleLike(index),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
