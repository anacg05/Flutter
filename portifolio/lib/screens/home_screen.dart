import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFF0A1F44),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Nome
            Text(
              'Ana Clara Grizotto',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10),

            // Cargo
            Text(
              'Digital Solutions • Bosch Brasil',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),

            // Botão principal
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sobremim');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF0A1F44),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                'Me conhecer',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}