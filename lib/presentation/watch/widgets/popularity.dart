import 'package:flutter/material.dart';

class Popularity extends StatelessWidget {
  final double popularity;
  const Popularity({required this.popularity,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.thumb_up,
          color: Colors.amber,
          size: 20,
        ),
        Text(
         ' ${popularity.toStringAsFixed(1)}'
        ),
      ],
    );
  }
}