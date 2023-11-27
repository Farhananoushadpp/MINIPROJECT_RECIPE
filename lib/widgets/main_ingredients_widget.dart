import 'package:flutter/material.dart';

class IngredientsWidget extends StatelessWidget {
  final List<String> ingredients;
  final Function(String) onTap;

  const IngredientsWidget({super.key, required this.ingredients, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(
                Icons.restaurant,
                color: Colors.blue, // Adjust color as needed
              ),
              SizedBox(width: 8),
              Text(
                "Main Ingredients:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust color as needed
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ingredients
                .map(
                  (ingredient) => GestureDetector(
                    onTap: () => onTap(ingredient),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue, // Adjust color as needed
                      ),
                      child: Text(
                        ingredient,
                        style: const TextStyle(
                          color: Colors.white, // Adjust color as needed
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
