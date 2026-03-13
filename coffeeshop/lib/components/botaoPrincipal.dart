import 'package:flutter/material.dart';

class BotaoPrincipal extends StatelessWidget {
  Widget pagina;
  String texto;

  BotaoPrincipal({super.key, required this.pagina, required this.texto});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 104, 52, 35),
        foregroundColor: Colors.white,
        fixedSize: Size(200, 50),
        side: BorderSide(color: const Color.fromARGB(122, 255, 255, 255), width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pagina),
        );
      },
      child: Text(
        texto,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
