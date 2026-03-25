import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String nome;
  final String imagem;
  final bool curtido;
  final VoidCallback onLike;

  const ProjectCard({
    required this.nome,
    required this.imagem,
    required this.curtido,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // IMAGEM
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
            child: Image.asset(
              imagem,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),

          // CONTEÚDO
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                  child: Text(
                    nome,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                IconButton(
                  icon: Icon(
                    curtido
                        ? Icons.favorite
                        : Icons.favorite_border,
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