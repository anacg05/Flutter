import 'package:flutter/material.dart';

class Descricao extends StatelessWidget {
  String texto; // componente espera receber uma variavel string
  Color? cor = Colors.black;
  Descricao({super.key, required this.texto, this.cor});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        color: cor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
