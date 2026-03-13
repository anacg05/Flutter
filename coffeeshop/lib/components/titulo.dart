import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
  String texto;
  Titulo({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: 30,
        color: const Color.fromARGB(255, 34, 25, 22),
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    );
  }
}
