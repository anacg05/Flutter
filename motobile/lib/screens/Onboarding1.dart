import 'package:flutter/material.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF020E5A), Colors.black],
                stops: [0, 0.5],
                begin: Alignment(0.03, -1),
                end: Alignment(-0.03, 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// TÍTULO
                  const Text(
                    'Motobile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// DESCRIÇÃO
                  const Padding(
                    padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
                    child: Text(
                      'Pesquise e compare os melhores preços para ter a sua moto.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),

                  /// BOTÃO ENTRAR
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: SizedBox(
                      width: 250,
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF001063),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          'Entre',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  /// BOTÃO CADASTRO
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: 250,
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF001063),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/cadastro');
                        },
                        child: const Text(
                          'Cadastre-se',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  /// IMAGEM
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image.asset(
                      'assets/images/mt.jpg',
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.40,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
