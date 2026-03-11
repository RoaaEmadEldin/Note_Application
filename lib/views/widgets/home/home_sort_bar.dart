import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/viewmodels/sort_option.dart';
import 'package:notes_app/views/widgets/home/home_sort_bottom_sheet.dart';

class HomeSortBar extends StatelessWidget {
  final int totalNotes;
  final int filteredCount;
  final bool isFiltered;
  final SortOption currentSort;
  final Function(SortOption) onSortChanged;

  const HomeSortBar({
    super.key,
    required this.totalNotes,
    required this.filteredCount,
    required this.isFiltered,
    required this.currentSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          Text(
            isFiltered
                ? '$filteredCount result${filteredCount != 1 ? 's' : ''}'
                : '$totalNotes note${totalNotes != 1 ? 's' : ''}',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => showSortBottomSheet(context, currentSort, onSortChanged),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.cardBackground,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: colorScheme.borderColor,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.sort_rounded,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    currentSort.displayName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.primary,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
