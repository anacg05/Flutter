import 'package:app_tarefas/screens/tela_delete.dart';
import 'package:app_tarefas/screens/tela_get.dart';
import 'package:app_tarefas/screens/tela_post.dart';
import 'package:app_tarefas/screens/tela_put.dart';
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
    const TelaGet(),
    const TelaDelete(),
    const TelaPost(),
    const TelaPut()
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF23627C), 
        selectedItemColor: const Color(0xFF23BBB7), 
        unselectedItemColor: const Color(0xFFF0EADF).withOpacity(0.6), 
        selectedFontSize: 14,
        unselectedFontSize: 12,
        currentIndex: indexAtual,
        onTap: mudarIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.get_app_rounded), 
            label: "Consultar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_forever_rounded), 
            label: "Excluir",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_rounded), 
            label: "Adicionar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar_rounded), 
            label: "Editar",
          ),
        ],
      ),
    );
  }
}