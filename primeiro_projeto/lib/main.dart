// biblioteca que importa os componentes do flutter
import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(TelaInicial());
}

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // tira a faixa vermelha escrito debug
      // material app provê os componentes para a tela
      home: Scaffold(
        // divide a tela em até 3 partes
        appBar: AppBar(
          title: Text(
            "Tela Inicial APP1",
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Arial",
            ),

            // textAlign: TextAlign.end, # Coloca o texto no final
          ),
          backgroundColor: const Color(0xFF011068),

          // centerTitle: true, # Coloca o texto no centro
        ),

        body: Column(
          spacing: 30, // espaçamento entre os componentes
          mainAxisAlignment:
              MainAxisAlignment.start, // alinhar entre em cima, meio e fim
          children: [
            Container(
              width: 50, 
              height: 50, 
              color: Colors.blueGrey,
              margin: EdgeInsets.only(top: 20),
            ),
            Container(
              width: 50,
              height: 50,
              color: const Color.fromARGB(255, 158, 158, 158),
            ),
            Container(
              width: 50,
              height: 50,
              color: const Color.fromARGB(255, 85, 85, 85),
            ),

            Row(
              spacing: 30, // espaçamento entre os componentes
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 50, 
                  height: 50, 
                  color: Colors.blueGrey,
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: const Color.fromARGB(255, 158, 158, 158),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: const Color.fromARGB(255, 85, 85, 85),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
