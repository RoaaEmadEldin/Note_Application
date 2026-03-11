import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/viewmodels/notes_viewmodel.dart';
import 'package:notes_app/views/widgets/settings/settings_info_tile.dart';

class SettingsStatisticsGrid extends StatelessWidget {
  final NotesViewModel viewModel;

  const SettingsStatisticsGrid({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final stats = [
      (
        'Total Notes',
        '${viewModel.totalNotes}',
        Icons.notes_rounded,
        colorScheme.primary,
      ),
      (
        'Categories',
        '${viewModel.allCategories.length}',
        Icons.category_rounded,
        colorScheme.warning,
      ),
      (
        'Most Used',
        viewModel.categoryStats.isEmpty
            ? '—'
            : (viewModel.categoryStats.entries.toList()
                  ..sort((a, b) => b.value.compareTo(a.value)))
                .first
                .key,
        Icons.star_rounded,
        colorScheme.tertiary,
      ),
    ];

    return Column(
      children:
          stats.asMap().entries.map((entry) {
            final index = entry.key;
            final s = entry.value;
            final (label, value, icon, color) = s;

            return Padding(
              padding: EdgeInsets.only(
                bottom: index < stats.length - 1 ? 10 : 0,
              ),
              child: SettingsInfoTile(
                icon: icon,
                iconColor: color,
                title: label,
                isStatsTile: true,
                statsValue: value,
              ),
            );
          }).toList(),
    );
  }
}
