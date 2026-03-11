import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String text;

  const SectionLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        fontSize: 11,
      ),
    );
  }
}
