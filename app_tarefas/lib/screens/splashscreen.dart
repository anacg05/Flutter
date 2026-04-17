import 'package:app_tarefas/screens/gerenciador_total.dart'; 
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
          MaterialPageRoute(builder: (context) => const GerenciadorTotal()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF23627C), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFD3EDEF), 
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.checklist_rtl_rounded,
                size: 80,
                color: Color(0xFF23BBB7), 
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Minhas Tarefas",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Color(0xFFF0EADF), 
                letterSpacing: 1.2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Divider(
                color: Color(0xFF23BBB7),
                height: 40,
                thickness: 2,
              ),
            ),
            const Text(
              "Criado por Ana Clara Grizotto",
              style: TextStyle(
                fontSize: 18, 
                color: Color(0xFFD3EDEF), 
                letterSpacing: 1.1,
                fontWeight: FontWeight.w500, 
              ),
            ),
            const SizedBox(height: 60),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF23BBB7)),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}