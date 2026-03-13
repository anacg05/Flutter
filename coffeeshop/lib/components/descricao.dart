import 'package:flutter/material.dart';

class Descricao extends StatelessWidget {
  String texto; // componente espera receber uma variavel string
  Color? cor = const Color.fromARGB(255, 85, 40, 25);
  Descricao({super.key, required this.texto, this.cor});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        color: cor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
