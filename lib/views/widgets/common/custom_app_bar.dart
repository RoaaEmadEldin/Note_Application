import 'package:flutter/material.dart';
import 'package:notes_app/views/widgets/common/custom_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          CustomIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            color: colorScheme.primary,
            bgColor: colorScheme.surface,
            onTap: onBackPressed ?? () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.headlineSmall),
                Text(subtitle, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
