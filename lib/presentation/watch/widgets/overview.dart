import 'package:flutter/material.dart';

class Overview extends StatelessWidget {
  final String overview;
  const Overview({required this.overview, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          overview,
        )
      ],
    );
  }
}
