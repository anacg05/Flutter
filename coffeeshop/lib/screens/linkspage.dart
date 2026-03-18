import 'package:coffeeshop/components/links.dart';
import 'package:flutter/material.dart';

class Linkspage extends StatelessWidget {
  const Linkspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Links(url: "https://github.com/anacg05", imagem: "https://cdn-icons-png.flaticon.com/512/25/25231.png")
          ],
        ),
      ),
    );
  }
}