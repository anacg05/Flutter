
import 'package:flutter/material.dart';

import 'screens/SplashScreen.dart';
import 'screens/Onboarding1.dart';
import 'screens/Onboarding2.dart';
import 'screens/Login.dart';
import 'screens/Cadastro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motobile',
      debugShowCheckedModeBanner: false,

      initialRoute: '/splash',

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding1': (context) => const Onboarding1(),
        // '/onboarding2': (context) => const Onboarding2,
        // '/login': (context) => const Login(),
        // '/cadastro': (context) => const Cadastro(),
      },
    );
  }
}

