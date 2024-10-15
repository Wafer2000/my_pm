import 'package:flutter/material.dart';

class MovieError extends StatelessWidget {
  const MovieError({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(child: Text(message)),
    );
  }
}
