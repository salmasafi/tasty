import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;
  final int maxLines;
  final double height;
  const RecipeCard({
    Key? key,
    required this.color,
    required this.text,
    required this.fontSize,
    required this.maxLines,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
