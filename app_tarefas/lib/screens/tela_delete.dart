import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaDelete extends StatefulWidget {
  const TelaDelete({super.key});

  @override
  State<TelaDelete> createState() => _TelaDeleteState();
}

class _TelaDeleteState extends State<TelaDelete> {
  List listaaApi = [];

  @override
  void initState() {
    super.initState();
    fazerGet();
  }

  void fazerGet() async {
    final respostaServidor = await http.get(Uri.parse("https://api-app-tarefas.onrender.com/tasks"));
    if (respostaServidor.statusCode == 200) {
      final dados = jsonDecode(respostaServidor.body);
      setState(() {
        listaaApi = dados;
      });
    }
  }

  void fazerDelete(final id) async {
    final respostaServidor = await http.delete(Uri.parse("https://api-app-tarefas.onrender.com/tasks/$id"));
    
    if (respostaServidor.statusCode == 200) {
      fazerGet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tarefa removida com sucesso."),
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
          "Excluir Tarefas",
          style: TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF23627C), 
        centerTitle: true,
        elevation: 0,
      ),
      body: listaaApi.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF23627C)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listaaApi.length,
              itemBuilder: (context, index) {
                final item = listaaApi[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFD3EDEF),
                      child: Icon(Icons.task, color: Color(0xFF23627C)), 
                    ),
                    title: Text(
                      item["title"],
                      style: const TextStyle(
                        color: Color(0xFF23627C), 
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent),
                      onPressed: () => _confirmarExclusao(item["id"], item["title"]),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _confirmarExclusao(id, titulo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color(0xFFF0EADF), 
        title: Column(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFF23627C), 
              size: 50,
            ),
            const SizedBox(height: 10),
            const Text(
              "Excluir Tarefa?",
              style: TextStyle(
                color: Color(0xFF23627C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          "Deseja excluir a tarefa '$titulo'?",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF23627C), fontSize: 16),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly, 
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "CANCELAR",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF23BBB7), 
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            onPressed: () {
              fazerDelete(id);
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "SIM, EXCLUIR",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}