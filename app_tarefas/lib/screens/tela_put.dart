import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class TelaPut extends StatefulWidget {
  const TelaPut({super.key});

  @override
  State<TelaPut> createState() => _TelaPutState();
}

class _TelaPutState extends State<TelaPut> {

  List listaApi = []; // lista que armazena os dados da API
  List controladores = [];  // lista que armazena todos os controladores

  @override
  void initState(){
    super.initState();
    fazerGet();

  }

  void fazerGet() async{
    final respostaServidor = await http.get(Uri.parse("https://api-app-tarefas.onrender.com/tasks"));
    if(respostaServidor.statusCode == 200){
      final dados = jsonDecode(respostaServidor.body);
      setState(() {
        listaApi = dados;
        controladores = []; 
        for(final item in listaApi){
          controladores.add(TextEditingController(text: item["title"]));
        }
      });
    }
  }

  void fazerPut(final id, final index) async{ // id do item e index da listacontroladores para o valor novo
    final respostaServidor = await http.patch(Uri.parse("https://api-app-tarefas.onrender.com/tasks/$id"),
    headers: {"Content-type":"application/json"}, 
    body: jsonEncode({
      "title": controladores[index].text
    }));

    if(respostaServidor.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Dado alterado com sucesso."),
          backgroundColor: Color(0xFF23BBB7),
        )
      );
    }
    fazerGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EADF),
      appBar: AppBar(
        title: const Text(
          "Tela Put/Patch",
          style: TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF23627C),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for(final item in listaApi)
          Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  item["title"],
                  style: const TextStyle(
                    color: Color(0xFF23627C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: controladores[listaApi.indexOf(item)],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFD3EDEF).withOpacity(0.3),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                trailing: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF23BBB7),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () => fazerPut(item["id"], listaApi.indexOf(item)),
                    icon: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}