import 'package:flutter/material.dart';

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

          return Container(
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGEM
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    projeto['imagem'],
                    width: MediaQuery.of(context).size.width * 0.95,
                    fit: BoxFit.fitWidth,
                  ),
                ),

                // CONTEÚDO
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // TÍTULO
                      Expanded(
                        child: Text(
                          projeto['nome'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // CURTIR
                      IconButton(
                        icon: Icon(
                          projeto['curtido']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: projeto['curtido'] ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => toggleLike(index),
                      ),
                    ],
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
