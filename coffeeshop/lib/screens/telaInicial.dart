import 'package:coffeeshop/components/botaoPrincipal.dart';
import 'package:coffeeshop/components/descricao.dart';
import 'package:coffeeshop/components/titulo.dart';
import 'package:coffeeshop/screens/telaPrincipal.dart';
import 'package:flutter/material.dart';

class Telainicial extends StatelessWidget {
  const Telainicial({super.key});

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
            Titulo(texto: "Bem vindo ao App de café"), // aparece o texto Coffee Shop
            Descricao(texto: "Clique no botão para entrar"),
            BotaoPrincipal(pagina: Principal(), texto: "Entrar"),
          ],
        ),
      ),
    );
  }
}