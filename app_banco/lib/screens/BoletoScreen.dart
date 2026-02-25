import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BoletoScreen extends StatefulWidget {
  const BoletoScreen({super.key});

  @override
  State<BoletoScreen> createState() => _BoletoScreenState();
}

class _BoletoScreenState extends State<BoletoScreen> {
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
                'Transferência via Boleto',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF171D3F),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
