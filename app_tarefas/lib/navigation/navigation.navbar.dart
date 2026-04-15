import 'package:app_tarefas/screens/tela_delete.dart';
import 'package:app_tarefas/screens/tela_get.dart';
import 'package:app_tarefas/screens/tela_post.dart';
import 'package:flutter/material.dart';
 
class NavBar extends StatefulWidget {
  const NavBar({super.key});
 
  @override
  State<NavBar> createState() => _NavbarState();
}
 
class _NavbarState extends State<NavBar> {
  // fazer a lógica aqui
  int indexAtual = 0;
 
  List pages = [    // lista para armazenar as paginas
    TelaGet(),
    TelaDelete(),
    TelaPost()
  ];

  void mudarIndex(int novoIndex){    // função para mudar a tela
    setState(() {
      indexAtual = novoIndex;
    });

  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(indexAtual),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.get_app_rounded), label: "Get"),
        BottomNavigationBarItem(icon: Icon(Icons.delete_forever_rounded), label: "Delete"),
        BottomNavigationBarItem(icon: Icon(Icons.post_add_rounded), label: "Post"),
      ],

      currentIndex: indexAtual,
      onTap: mudarIndex,
      
      ),
    );
  }
}