import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Links extends StatelessWidget {
  String url;
  String imagem;
  Links({
    super.key,
    required this.url,
    required this.imagem,
  }); //required = obrigatório

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width* 0.2,  // 20% da tela
      height: 200,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          GestureDetector(
            // atribui uma ação ao componente filho
            // toda vez que clicar na imagem, ele navega para o link externo
            child: Image.network(imagem),
            onTap: () async {
              // para o flutter entender a url, transforme para uri
              Uri converterUrl = Uri.parse(url);
              if (await canLaunchUrl(converterUrl)) {
                // se a função de lanch for true
                await (launchUrl(
                  converterUrl,
                )); // espera a transição para o link externo
              }
            },
          ),
        ],
      ),
    );
  }
}

// Links(url:"www.google.com", imagem:"https....")
