import 'package:flutter/material.dart';

class NoteDetailsHeader extends StatelessWidget {
  final Color borderColor;
  final String title;

  const NoteDetailsHeader({
    super.key,
    required this.borderColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [borderColor, borderColor.withValues(alpha: 0.3)],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        // Title
        Text(title, style: theme.textTheme.headlineMedium),
      ],
    );
  }
}
