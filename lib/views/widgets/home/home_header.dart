import 'package:flutter/material.dart';
import 'package:notes_app/viewmodels/notes_viewmodel.dart';
import 'package:notes_app/views/widgets/common/custom_icon_button.dart';
import 'package:notes_app/views/widgets/home/home_stats_dialog.dart';

class HomeHeader extends StatelessWidget {
  final NotesViewModel viewModel;
  final VoidCallback onSettingsTap;

  const HomeHeader({
    super.key,
    required this.viewModel,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.primary.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text('My Notes', style: theme.textTheme.headlineLarge),
              ],
            ),
          ),
          // Stats badge
          _StatsBadge(viewModel: viewModel),
          const SizedBox(width: 8),

          CustomIconButton(
            icon: Icons.settings_rounded,
            color: colorScheme.primary,
            bgColor: colorScheme.surface,
            onTap: onSettingsTap,
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning ☀️';
    if (hour < 17) return 'Good afternoon 🌤️';
    return 'Good evening 🌙';
  }
}


class _StatsBadge extends StatelessWidget {
  final NotesViewModel viewModel;

  const _StatsBadge({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => showStatsDialog(context, viewModel),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primary, colorScheme.primary.withValues(alpha: 0.8)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.notes_rounded, color: Colors.white, size: 16),
            const SizedBox(width: 6),
            Text(
              '${viewModel.totalNotes}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}