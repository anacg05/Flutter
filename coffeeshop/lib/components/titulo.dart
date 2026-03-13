import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
  String texto;
  Titulo({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: 50,
        color: const Color.fromARGB(255, 255, 255, 255),
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
      ),
    );
  }
}
