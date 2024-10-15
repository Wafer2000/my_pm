import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReleaseDate extends StatelessWidget {
  final String releaseDate;
  const ReleaseDate({required this.releaseDate, super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final DateTime date = DateTime.parse(releaseDate);
    final String formattedDate = dateFormat.format(date);
    return Row(
      children: [
        const Icon(
          Icons.calendar_month,
          size: 20,
          color: Colors.grey,
        ),
        Text(
          ' $formattedDate',
          style: const TextStyle(
            color: Colors.grey,
          ),
        )
      ],
    );
  }
}
