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
  TextEditingController valorDigitado = TextEditingController();
  bool podeAdicionar = false;

  @override
  void initState() {
    super.initState(); // garante que funcione no estadoinicial
    fazerGet();
    
    valorDigitado.addListener(() {
      setState(() {
        podeAdicionar = valorDigitado.text.trim().isNotEmpty;
      });
    });
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

  void fazerPost() async {
    if (valorDigitado.text.trim().isEmpty) return;

    final respostaServidor = await http.post(
      Uri.parse("https://api-app-tarefas.onrender.com/tasks"),
      headers: {"Content-Type": "application/json"}, // enviando um json para o post
      body: jsonEncode({"title": valorDigitado.text.trim()}),
    );

    if (respostaServidor.statusCode == 201 || respostaServidor.statusCode == 200) {
      valorDigitado.clear();
      fazerGet();
      FocusScope.of(context).unfocus(); // Fecha o teclado após adicionar
    }
  }

  void fazerDelete(final id) async {
    final respostaServidor = await http.delete(Uri.parse("https://api-app-tarefas.onrender.com/tasks/$id"));
    if (respostaServidor.statusCode == 200) {
      fazerGet(); // atualiza a tela
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
            Text(
              "Excluir Tarefa?",
              style: TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          "Deseja realmente apagar '$titulo'?",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFFD3EDEF)),
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
          style: TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        backgroundColor: const Color(0xFF1A3E4D),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: valorDigitado,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "O que vamos fazer hoje?",
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF1A3E4D),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: podeAdicionar ? fazerPost : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: podeAdicionar ? const Color(0xFF23BBB7) : Colors.white10,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add_rounded, 
                      color: podeAdicionar ? Colors.white : Colors.white24, 
                      size: 30
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: listaaApi.length,
              // Define que o arrasto não será automático ao segurar, mas sim controlado
              buildDefaultDragHandles: false, 
              // Garante que o card mantenha sua aparência real durante o arraste
              proxyDecorator: (Widget child, int index, Animation<double> animation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    return Material(
                      elevation: 4,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      child: child,
                    );
                  },
                  child: child,
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
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
                    side: BorderSide(color: Colors.white.withOpacity(0.05))
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    // Envolve o ícone no listener para arrastar IMEDIATAMENTE ao clicar
                    leading: ReorderableDragStartListener(
                      index: index,
                      child: const Icon(Icons.reorder_rounded, color: Colors.white24, size: 28),
                    ),
                    title: Text(
                      item["title"],
                      style: const TextStyle(
                        color: Color(0xFFF0EADF),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_note_rounded, color: Color(0xFFD3EDEF)),
                          onPressed: () => _modalEditar(item),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFF23BBB7)),
                          onPressed: () => _confirmarExclusao(item["id"], item["title"]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _modalEditar(Map item) {
    TextEditingController edtController = TextEditingController(text: item["title"]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: const Color(0xFF1A3E4D),
        title: const Text(
          "Editar Tarefa", 
          style: TextStyle(color: Color(0xFFF0EADF), fontWeight: FontWeight.bold)
        ),
        content: TextField(
          controller: edtController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Novo nome da tarefa",
            hintStyle: TextStyle(color: Colors.white38),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCELAR", style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF23BBB7)),
            onPressed: () {
              if (edtController.text.trim().isNotEmpty) {
                fazerPut(item["id"], edtController.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text("SALVAR", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}