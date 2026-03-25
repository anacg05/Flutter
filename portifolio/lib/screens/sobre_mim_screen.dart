import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SobreMimScreen extends StatelessWidget {
  void abrirLink(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre Mim', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0A1F44),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // FOTO
            Center(
              child: Container(
                padding: EdgeInsets.all(3), 
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF0A1F44), width: 2),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/eu.jpg'),
                ),
              ),
            ),

            SizedBox(height: 20),

            // NOME
            Text(
              'Ana Clara Grizotto',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 15),

            // BIO
            Text(
              'Tenho 21 anos e atualmente atuo na área de Digital Solutions na Bosch Brasil. '
              'Estou buscando evoluir minhas habilidades e criar soluções úteis e eficientes.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.7),
            ),

            SizedBox(height: 15),

            // FORMAÇÃO
            Text(
              'Formação Acadêmica',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            SizedBox(height: 10),

            Text(
              '• Cursando Técnico em Desenvolvimento de Sistemas - SENAI Roberto Mange\n'
              '• Bacharelado em Análise e Desenvolvimento de Sistemas - UNIP Campinas\n'
              '• Técnico em Informática - IFSP Hortolândia',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.7),
            ),

            SizedBox(height: 20),

            Text(
              'Redes Sociais',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            SizedBox(height: 15),

            // REDES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // INSTAGRAM
                InkWell(
                  onTap: () =>
                      abrirLink('https://www.instagram.com/anaclaragzt'),
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/256/3955/3955024.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(width: 20),

                // LINKEDIN
                InkWell(
                  onTap: () => abrirLink(
                    'https://www.linkedin.com/in/ana-clara-grizotto',
                  ),
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/145/145807.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(width: 20),

                // GITHUB
                InkWell(
                  onTap: () => abrirLink('https://github.com/anacg05'),
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/25/25231.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            Text(
              'Clique aqui para ver alguns dos meus projetos:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),

            SizedBox(height: 20),

            // BOTÃO PROJETOS
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/projetos');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0A1F44),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                ),
                child: Text('Ver meus projetos'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
