import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final Color accentColor;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.accentColor,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 90,
        height: 85,
        decoration: BoxDecoration(
          color: isSelected ? accentColor.withOpacity(0.15) : MonsterColors.cardGrey,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? accentColor : Colors.white.withOpacity(0.05),
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: accentColor.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? accentColor : Colors.white.withOpacity(0.3),
              size: 26,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.bold,
                fontSize: 12,
                shadows: isSelected
                    ? [Shadow(color: accentColor, blurRadius: 6)]
                    : [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}