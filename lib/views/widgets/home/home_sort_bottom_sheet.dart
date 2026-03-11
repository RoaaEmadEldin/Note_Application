import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/viewmodels/sort_option.dart';

void showSortBottomSheet(
  BuildContext context,
  SortOption currentSort,
  Function(SortOption) onSortChanged,
) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  showModalBottomSheet(
    context: context,
    backgroundColor: colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder:
        (ctx) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Sort by', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              ...SortOption.values.map((option) {
                final isSelected = currentSort == option;
                return GestureDetector(
                  onTap: () {
                    onSortChanged(option);
                    Navigator.pop(ctx);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? colorScheme.primary.withValues(alpha: 0.1)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color:
                            isSelected
                                ? colorScheme.primary.withValues(alpha: 0.3)
                                : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          option.icon,
                          size: 20,
                          color:
                              isSelected
                                  ? colorScheme.primary
                                  : colorScheme.textTertiary,
                        ),
                        const SizedBox(width: 14),
                        Text(
                          option.displayFullName,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                            color:
                                isSelected
                                    ? colorScheme.primary
                                    : colorScheme.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        if (isSelected)
                          Icon(
                            Icons.check_rounded,
                            color: colorScheme.primary,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        ),
  );
}
