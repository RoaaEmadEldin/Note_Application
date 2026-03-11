import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';

class LoadingIndicator extends StatelessWidget {
  final String message;
  const LoadingIndicator({super.key, this.message = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: colorScheme.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
