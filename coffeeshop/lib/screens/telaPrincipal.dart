import 'package:coffeeshop/components/cards.dart';
import 'package:flutter/material.dart';
import 'package:coffeeshop/components/titulo.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Coffee Shop",
        style: TextStyle(
          color: Colors.white,
        ),        ),
        backgroundColor: const Color.fromARGB(255, 85, 40, 25),
      ),

      body: Center(
        child: Column(
          children: [
            Titulo(texto: "Confira o menu de cafés:"), // aparece o texto Coffee Shop
            Cards( nome: "Espresso", valor: 3.50, imagem: "assets/im1.png",),
             Cards( nome: "Cappuccino", valor: 10.00, imagem: "assets/im2.png",),
              Cards( nome: "Americano", valor: 7.50, imagem: "assets/im3.png",),
          ],
        ),
      ),
    );
  }
}