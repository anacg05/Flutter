import 'package:app_tarefas/navigation/navigation.navbar.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override // garante que a função resete toda vez que iniciar o app
  // sempre a lógica antes do override
  void initState() {
    //atribuir instruções no estado inicial da tela (carregamento)
    super.initState();
    Future.delayed(
      // espera 3 segundos e depois realiza uma ação
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.checklist_rtl_rounded, 
              size: 100, 
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              "Minhas Tarefas",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Divider(
                color: Colors.white54,
                height: 40,
                thickness: 1.5,
              ),
            ),
            const Text(
              "Gerenciamento de Tarefas",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}