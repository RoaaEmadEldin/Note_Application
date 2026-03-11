import 'package:flutter/material.dart';

class NoteCategoryTagChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isTagChip;

  const NoteCategoryTagChip({
    super.key,
    required this.label,
    required this.color,
    this.isTagChip = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isTagChip ? const EdgeInsets.only(right: 6) : EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isTagChip ? '#$label' : label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
