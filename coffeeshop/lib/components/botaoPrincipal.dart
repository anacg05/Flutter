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
        foregroundColor: Colors.white,  // cor da fonte
        fixedSize: Size(100, 20), // width e height
      ),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => pagina));
      },
      child: Text(texto),
      
    );
  }
}