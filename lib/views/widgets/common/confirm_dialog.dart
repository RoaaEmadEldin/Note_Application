import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';

Future<bool?> confirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmButtonText,
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return showDialog<bool>(
    context: context,
    builder:
        (cntxt) => AlertDialog(
          backgroundColor: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.secondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: colorScheme.secondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 16),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 14, height: 1.5),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(cntxt, false),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: colorScheme.textTertiary,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(cntxt, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: Colors.white,
              ),
              icon: Icon(Icons.delete_forever_rounded, size: 16),
              label: Text(confirmButtonText),
            ),
          ],
        ),
  );
}
