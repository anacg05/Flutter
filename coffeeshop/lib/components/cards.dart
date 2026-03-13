import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String nome;
  final double valor;
  final String imagem;

  const Cards({
    super.key,
    required this.imagem,
    required this.nome,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 110,
      margin: const EdgeInsets.only(bottom: 5, top: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 235, 235),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          // IMAGEM
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagem,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 15),

          // TEXTO
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                    color: const Color.fromARGB(255, 85, 40, 25),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "R\$ ${valor.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
