import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Importa sua tela principal
import 'theme/colors.dart'; // Importa sua paleta Monster

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monster Zone App',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: MonsterColors.neonGreen,
        scaffoldBackgroundColor: MonsterColors.backgroundBlack,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
      ),
      
      home: const HomeScreen(),
    );
  }
}