import 'package:flutter/material.dart';
import '../../../../config/color_scheme_extensions.dart';

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_rounded : Icons.check_circle_rounded,
              color: isError ? colorScheme.error : colorScheme.primary,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontFamily: 'Poppins', color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: colorScheme.snackBarBackground,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    show(context, message: message, isError: false);
  }

  static void showError(BuildContext context, String message) {
    show(context, message: message, isError: true);
  }
}