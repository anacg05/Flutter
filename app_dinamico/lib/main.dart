import 'package:flutter/material.dart';

void main() {
  // função principal que executa o código
  // roda o app
  runApp(TelaContador());
}

class TelaContador extends StatefulWidget {
  // Aqui coloca os parametros
  const TelaContador({super.key});

  @override
  State<TelaContador> createState() => _TelaContadorState();
}

class _TelaContadorState extends State<TelaContador> {
  // Aqui coloca a lógica em dart

  int contador = 0;

  void add() {
    setState(() {
      // para nao recarregar a pag toda vez que o contador mudar
      contador++; // soma 1
    });
  }

  void sub() {
    setState(() {
      // if(contador>0){
      //   contador--;
      // }

      contador--;
    });
  }

  void reset() {
    setState(() {
      contador = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // importa todos os widgets/componentes (texto, botao, navbar...)
      home: Scaffold(
        // permite separar a tela em até 3 partes
        appBar: AppBar(title: Text("App Contador")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$contador"),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(style: TextButton.styleFrom(backgroundColor: const Color.fromARGB(255, 150, 189, 255)), onPressed: add, child: Icon(Icons.add)),
                  TextButton(onPressed: sub, child: Icon(Icons.remove)),
                  TextButton(onPressed: reset,child: Icon(Icons.refresh_sharp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
