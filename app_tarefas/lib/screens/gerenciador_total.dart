import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GerenciadorTotal extends StatefulWidget {
  const GerenciadorTotal({super.key});

  @override
  State<GerenciadorTotal> createState() => _GerenciadorTotalState();
}

class _GerenciadorTotalState extends State<GerenciadorTotal> {
  // lógica
  List listaaApi = [];

  @override
  void initState() {
    super.initState(); // garante que funcione no estado inicial
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

  void fazerPost(String titulo) async {
    final respostaServidor = await http.post(
      Uri.parse("https://api-app-tarefas.onrender.com/tasks"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": titulo}),
    );

    if (respostaServidor.statusCode == 201 || respostaServidor.statusCode == 200) {
      fazerGet();
    }
  }

  void fazerDelete(final id) async {
    final respostaServidor = await http.delete(Uri.parse("https://api-app-tarefas.onrender.com/tasks/$id"));
    if (respostaServidor.statusCode == 200) {
      fazerGet();
    }
  }

  void fazerPut(final id, String novoTitulo) async {
    await http.patch(
      Uri.parse("https://api-app-tarefas.onrender.com/tasks/$id"),
      headers: {"Content-type":"application/json"},
      body: jsonEncode({"title": novoTitulo}),
    );
    fazerGet();
  }

  // Modal para adicionar nova tarefa
  void _modalAdicionar() {
    TextEditingController addController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color(0xFF1A3E4D),
        title: const Column(
          children: [
            Icon(Icons.playlist_add_rounded, color: Color(0xFF23BBB7), size: 50),
            SizedBox(height: 10),
            Text("Nova Tarefa", style: TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.bold)),
          ],
        ),
        content: TextField(
          controller: addController,
          autofocus: true,
          cursorColor: Colors.white, // Cursor branco solicitado
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "O que vamos fazer?",
            hintStyle: const TextStyle(color: Colors.white24),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF23BBB7))),
          ),
        ),
        actionsPadding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCELAR", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF23BBB7),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              if (addController.text.trim().isNotEmpty) {
                fazerPost(addController.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text("ADICIONAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Modal para editar tarefa
  void _modalEditar(Map item) {
    TextEditingController edtController = TextEditingController(text: item["title"]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color(0xFF1A3E4D),
        title: const Column(
          children: [
            Icon(Icons.edit_note_rounded, color: Color(0xFFD3EDEF), size: 50),
            SizedBox(height: 10),
            Text("Editar Tarefa", style: TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.bold)),
          ],
        ),
        content: TextField(
          controller: edtController,
          autofocus: true,
          cursorColor: Colors.white, // Cursor branco solicitado
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Novo nome da tarefa",
            hintStyle: const TextStyle(color: Colors.white24),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF23BBB7))),
          ),
        ),
        actionsPadding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCELAR", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF23BBB7),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              if (edtController.text.trim().isNotEmpty) {
                fazerPut(item["id"], edtController.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text("SALVAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _confirmarExclusao(final id, String titulo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color(0xFF1A3E4D),
        title: const Column(
          children: [
            Icon(Icons.warning_amber_rounded, color: Color(0xFF23BBB7), size: 50),
            SizedBox(height: 10),
            Text("Excluir Tarefa?", style: TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          "Deseja apagar '$titulo'?", 
          textAlign: TextAlign.center, 
          style: const TextStyle(color: Color(0xFFD3EDEF))
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCELAR", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF23BBB7),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              fazerDelete(id);
              Navigator.pop(context);
            },
            child: const Text("EXCLUIR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1F27),
      appBar: AppBar(
        title: const Text(
          "Minhas Tarefas", 
          style: TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.bold)
        ),
        backgroundColor: const Color(0xFF1A3E4D),
        centerTitle: false, 
        elevation: 0,
      ),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        itemCount: listaaApi.length,
        buildDefaultDragHandles: false,
        proxyDecorator: (Widget child, int index, Animation<double> animation) {
          return Material(
            elevation: 4,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            child: child,
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) newIndex -= 1;
            final item = listaaApi.removeAt(oldIndex);
            listaaApi.insert(newIndex, item);
          });
        },
        itemBuilder: (context, index) {
          final item = listaaApi[index];
          return Card(
            key: ValueKey(item["id"]),
            elevation: 0,
            color: const Color(0xFF1A3E4D),
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.white.withOpacity(0.05)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              leading: ReorderableDragStartListener(
                index: index,
                child: const Icon(Icons.reorder_rounded, color: Colors.white24, size: 28),
              ),
              title: Text(
                item["title"], 
                style: const TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.w600)
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFFD3EDEF)), 
                    onPressed: () => _modalEditar(item)
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFF23BBB7)), 
                    onPressed: () => _confirmarExclusao(item["id"], item["title"])
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF23BBB7),
        onPressed: _modalAdicionar,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 35),
      ),
    );
  }
}