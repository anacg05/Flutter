import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String url;
  final String imageUrl;
  final Function(String) onTap;

  const SocialButton({
    super.key,
    required this.url,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(url),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Image.network(imageUrl, width: 30, height: 30),
      ),
    );
  }
}
