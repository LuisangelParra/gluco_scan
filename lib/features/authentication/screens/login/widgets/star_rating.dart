import 'package:flutter/material.dart';

/// Fila de 5 estrellas amarillas.
class StarRating extends StatelessWidget {
  final int count;
  final double size;
  final Color color;

  const StarRating({
    super.key,
    this.count = 5,
    this.size = 32,
    this.color = const Color(0xFFE9BF06), // ámbar
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (_) {
        return Icon(Icons.star, color: color, size: size);
      }),
    );
  }
}
