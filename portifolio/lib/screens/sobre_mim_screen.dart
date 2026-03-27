import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/social_button.dart';

class SobreMimScreen extends StatelessWidget {
  const SobreMimScreen({super.key});

  static const Color primaryBlue = Color(0xFF0A1F44);
  static const Color accentBlue = Color(0xFF1A3A77);
  static const Color scaffoldBg = Color(0xFFF5F6FA);

  void abrirLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw 'Não foi possível abrir $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: const Text(
          'Sobre Mim',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 30),
            _buildSectionCard(
              title: 'Bio',
              content: const Text(
                'Tenho 21 anos e atualmente atuo na área de Digital Solutions na Bosch Brasil. '
                'Estou buscando evoluir minhas habilidades e criar soluções úteis e eficientes.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              title: 'Formação Acadêmica',
              content: Column(
                children: [
                  _buildAcademicItem(
                    Icons.code,
                    'Técnico em Desenvolvimento de Sistemas - SENAI Roberto Mange',
                  ),
                  _buildAcademicItem(
                    Icons.school,
                    'Bacharelado em Análise e Desenvolvimento de Sistemas - UNIP Campinas',
                  ),
                  _buildAcademicItem(
                    Icons.computer,
                    'Técnico em Informática - IFSP Hortolândia',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Redes Sociais',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryBlue,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialButton(
                  url: 'https://www.instagram.com/anaclaragzt',
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/256/3955/3955024.png',
                  onTap: abrirLink,
                ),
                const SizedBox(width: 20),
                SocialButton(
                  url: 'https://www.linkedin.com/in/ana-clara-grizotto',
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/512/145/145807.png',
                  onTap: abrirLink,
                ),
                const SizedBox(width: 20),
                SocialButton(
                  url: 'https://github.com/anacg05',
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/512/25/25231.png',
                  onTap: abrirLink,
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Clique abaixo para ver meus projetos:',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 15),

            _buildGradientButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [primaryBlue, accentBlue],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, '/projetos'),
        icon: const Icon(Icons.rocket_launch_rounded),
        label: const Text(
          'Ver meus projetos',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: primaryBlue, width: 3),
            boxShadow: [
              BoxShadow(
                color: primaryBlue.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const CircleAvatar(
            radius: 65,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/eu.jpg'),
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Ana Clara Grizotto',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({required String title, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), //
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
          const Divider(height: 25, thickness: 1),
          content,
        ],
      ),
    );
  }

  Widget _buildAcademicItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: primaryBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
