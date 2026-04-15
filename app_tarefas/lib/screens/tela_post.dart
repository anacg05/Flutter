import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TelaPost extends StatefulWidget {
  const TelaPost({super.key});

  @override
  State<TelaPost> createState() => _TelaPostState();
}

class _TelaPostState extends State<TelaPost> {
  // variavel que observa o que o usuario digita
  TextEditingController valorDigitado = TextEditingController();

  void fazerPost() async{
    final respostaServidor = await http.post(Uri.parse("http://10.109.72.6:3000/tasks"),
    headers: {"Content-Type": "application/json"},  // enviando um json para o post
    body: jsonEncode({
      "title": valorDigitado.text   // o novo registro da api receberá no campo title o valor digitado
    })
    );

    if(respostaServidor.statusCode == 201 || respostaServidor.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dado enviado com sucesso."))
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela POST"),),
      body: Center(
        child: Column(
          children: [
            TextField(controller: valorDigitado,),
            TextButton(onPressed: fazerPost, child: Text("Adicionar Dado"))
          ],
        ),
      ),
    );
  }
}