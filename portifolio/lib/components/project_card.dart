import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String nome;
  final String imagem;
  final bool curtido;
  final VoidCallback onLike;

  const ProjectCard({
    super.key,
    required this.nome,
    required this.imagem,
    required this.curtido,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagem,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    nome,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    curtido ? Icons.favorite : Icons.favorite_border,
                    color: curtido ? Colors.red : Colors.grey,
                  ),
                  onPressed: onLike,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
