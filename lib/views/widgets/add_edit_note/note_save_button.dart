import 'package:flutter/material.dart';

class NoteSaveButton extends StatelessWidget {
  final bool isEditing;
  final Color color;
  final VoidCallback onPressed;

  const NoteSaveButton({
    super.key,
    required this.isEditing,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.7)]),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isEditing ? Icons.check_circle_rounded : Icons.save_rounded,
                color: Colors.white,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                isEditing ? 'Save Changes' : 'Save Note',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
