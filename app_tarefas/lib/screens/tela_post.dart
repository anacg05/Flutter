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

  void fazerPost() async {
    final respostaServidor = await http.post(
      Uri.parse("https://api-app-tarefas.onrender.com/tasks"),
      headers: {"Content-Type": "application/json"}, 
      body: jsonEncode({
        "title": valorDigitado.text 
      }),
    );

    if (respostaServidor.statusCode == 201 || respostaServidor.statusCode == 200) {
      valorDigitado.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tarefa adicionada com sucesso!"),
          backgroundColor: Color(0xFF23BBB7), 
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EADF), 
      appBar: AppBar(
        title: const Text(
          "Nova Tarefa",
          style: TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF23627C), 
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_task_rounded,
              size: 80,
              color: Color(0xFF23627C), 
            ),
            const SizedBox(height: 32),
            TextField(
              controller: valorDigitado,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "O que precisa ser feito?",
                labelText: "Título da Tarefa",
                labelStyle: const TextStyle(color: Color(0xFF23627C)),
                prefixIcon: const Icon(Icons.edit_note, color: Color(0xFF23BBB7)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF23BBB7), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: fazerPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF23627C), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  "ADICIONAR TAREFA",
                  style: TextStyle(
                    color: Color(0xFFF0EADF), 
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}