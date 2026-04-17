import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaGet extends StatefulWidget {
  const TelaGet({super.key});

  @override
  State<TelaGet> createState() => _TelaGetState();
}

class _TelaGetState extends State<TelaGet> {
  // logica
  String resultado = "Nenhum dado carregado";

  void fazerGet() async {
    //função assincrona, pois espera o resultado da requisição/servidor
    final respostaServidor = await http.get(
      Uri.parse("https://api-app-tarefas.onrender.com/tasks"),
    );

    if (respostaServidor.statusCode == 200) {
      final dados = jsonDecode(respostaServidor.body);

      setState(() {
        // Pega o título do primeiro item da lista
        resultado = dados.isNotEmpty ? dados[0]["title"] : "Lista vazia";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EADF),
      appBar: AppBar(
        title: const Text(
          "Consultar Tarefa",
          style: TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF23627C), 
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12), 
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.manage_search_rounded,
                      size: 60,
                      color: Color(0xFF23BBB7), 
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Resultado da Consulta:",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      resultado,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF23627C),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: fazerGet,
                  icon: const Icon(Icons.download_rounded, color: Color(0xFFF0EADF)),
                  label: const Text(
                    "BUSCAR DADOS",
                    style: TextStyle(
                      color: Color(0xFFF0EADF), 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF23BBB7), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}