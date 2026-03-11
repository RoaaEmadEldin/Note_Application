import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';

class NoteDetailsContent extends StatelessWidget {
  final String content;
  final Color bgColor;
  final Color borderColor;

  const NoteDetailsContent({
    super.key,
    required this.content,
    required this.bgColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border(left: BorderSide(color: borderColor, width: 4)),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 16,
          height: 1.8,
          fontFamily: 'Poppins',
          color: colorScheme.textSecondary,
        ),
      ),
    );
  }
}
