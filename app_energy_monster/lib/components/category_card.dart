import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final Color accentColor;
  final IconData icon;

  const CategoryCard({
    super.key,
    required this.title,
    required this.accentColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MonsterColors.cardGrey,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: accentColor.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accentColor, size: 40),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              shadows: [Shadow(color: accentColor, blurRadius: 8)],
            ),
          ),
        ],
      ),
    );
  }
}
