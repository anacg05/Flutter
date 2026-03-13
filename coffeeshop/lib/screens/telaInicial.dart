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
      body: Stack(
        children: [

          // IMAGEM DE FUNDO
          SizedBox.expand(
            child: Image.asset(
              "assets/imagem.jpg",
              fit: BoxFit.cover,
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          // CONTEÚDO
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Titulo(texto: "Coffee Shop"),

                  const SizedBox(height: 20),

                  Descricao(
                    texto: "O melhor café da cidade",
                    cor: Colors.white,
                  ),

                  const SizedBox(height: 40),

                  BotaoPrincipal(
                    pagina: Principal(),
                    texto: "Entrar",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}