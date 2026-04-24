import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaLocal extends StatefulWidget {
  const TelaLocal({super.key});

  @override
  State<TelaLocal> createState() => _TelaLocalState();
}

class _TelaLocalState extends State<TelaLocal> {
  List<String> itens = [];
  TextEditingController valorDigitado = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    final dados =
        await SharedPreferences.getInstance(); // espera o banco iniciar
    setState(() {
      itens =
          dados.getStringList('nomes') ??
          []; // se não tiver nada na gaveta de nomes, a lista é vazia
    });
  }

  void criarDados() async {
    final dados = await SharedPreferences.getInstance();
    setState(() {
      itens.add(valorDigitado.text);
    });

    await dados.setStringList('nomes', itens);
    carregarDados();
  }

  void deletarDados(int index) async{
    final dados = await SharedPreferences.getInstance();
    setState(() {
      itens.removeAt(index);      
    });
    
    await dados.setStringList('nomes', itens);
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Armazenamento Local"),),
      body: ListView(
        children: [
          TextField(controller: valorDigitado,),
          TextButton(onPressed: criarDados, child: Text("Criar Dado")),
          for(final nome in itens)
          Card(
            child: ListTile(
              leading: Text(nome),
              trailing: GestureDetector(
                onTap: () => deletarDados(itens.indexOf(nome)),
                child: Icon(Icons.remove_circle_outline_rounded),
              ),
            ),
          )
        ],
      ),
    );
  }
}
