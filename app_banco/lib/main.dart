import 'package:app_banco/Screens/PixScreen.dart';
import 'package:app_banco/screens/CartaoScreen.dart';
import 'package:app_banco/screens/BoletoScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F4F5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        leadingWidth: 140,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SvgPicture.asset(
            'assets/logo-gradient.svg',
            fit: BoxFit.contain,
          ),
        ),
      ),

      body: Column(
        children: [
          // TEXTO DE BOAS-VINDAS
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bem-vindo ao Neon Bank!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF171D3F),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // IMAGEM
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              'assets/image.png',
              width: double.infinity,
              height: 350,
              fit: BoxFit.contain,
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pagar com:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF171D3F),
                ),
              ),
            ),
          ),

          // BOTÕES
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    botaoGradiente(
                      imagem: 'assets/pix.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PixScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(width: 60),

                    // BOTÃO CARTAO
                    botaoGradiente(
                      imagem: 'assets/cartao.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartaoScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(width: 60),

                    // BOTAO BOLETO
                    botaoGradiente(
                      imagem: 'assets/boleto.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BoletoScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget botaoGradiente({required String imagem, required VoidCallback onTap}) {
  return InkWell(
    borderRadius: BorderRadius.circular(14),
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF28cccc), // verde
            Color(0xFF04a8fc), // azul
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Image.asset(imagem, height: 28, width: 28),
    ),
  );
}
