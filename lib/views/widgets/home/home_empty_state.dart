import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';

class HomeEmptyState extends StatelessWidget {
  final bool isFiltered;
  final VoidCallback onClearFilters;

  const HomeEmptyState({
    super.key,
    required this.isFiltered,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors:
                      isFiltered
                          ? [
                            colorScheme.warning.withValues(alpha: 0.2),
                            colorScheme.warning.withValues(alpha: 0.05),
                          ]
                          : [
                            colorScheme.primary.withValues(alpha: 0.2),
                            colorScheme.primary.withValues(alpha: 0.05),
                          ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFiltered ? Icons.search_off_rounded : Icons.note_add_rounded,
                size: 48,
                color:
                    isFiltered ? colorScheme.warning : colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isFiltered ? 'No Notes Found' : 'No Notes Yet',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              isFiltered
                  ? 'Try adjusting your search or filters'
                  : 'Tap the button below to create your first note',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            if (isFiltered) ...[
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onClearFilters,
                icon: const Icon(Icons.clear_all_rounded),
                label: const Text('Clear filters'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.warning,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
