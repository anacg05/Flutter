import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaDelete extends StatefulWidget {
  const TelaDelete({super.key});

  @override
  State<TelaDelete> createState() => _TelaDeleteState();
}

class _TelaDeleteState extends State<TelaDelete> {

  // lógica
  List listaaApi = [];

  @override
  void initState() {
    super.initState();  // garante que funcione no estadoinicial

    fazerGet();
  }

  void fazerGet() async{
    final respostaServidor = await http.get(Uri.parse("http://10.109.72.6:3000/tasks"));
    if(respostaServidor.statusCode == 200){
      final dados = jsonDecode(respostaServidor.body);
      setState(() {
        listaaApi = dados;
      });
    }
  }

  void fazerDelete(final id) async{
    final respostaServidor = await http.delete(Uri.parse("http://10.109.72.6:3000/tasks/$id"));
    
    if(respostaServidor.statusCode == 200){
      fazerGet(); // atualiza a tela

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dado deletado com sucesso."))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Delete"),),
      body: ListView( // permite a rolagem de tela
        children: [
          for(final item in listaaApi)
          Card(
            child: ListTile(
              leading: Text(item["title"]),
              trailing: GestureDetector(
                onTap: ()=>fazerDelete(item["id"]),
                child: Icon(Icons.delete),
              ),
            ),
          )
        ],
      ),
    );
  }
}