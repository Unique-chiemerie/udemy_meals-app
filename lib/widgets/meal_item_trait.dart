import 'package:flutter/material.dart';

class MealItemtrait extends StatelessWidget {
  const MealItemtrait({super.key, required this.icon, required this.label});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
