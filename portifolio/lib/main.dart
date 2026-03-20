import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/projetos_screen.dart';
import 'screens/sobre_mim_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfólio',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/sobremim': (context) => SobreMimScreen(),
        '/projetos': (context) => ProjetosScreen(),
      },
    );
  }
}

