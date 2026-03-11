import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';

class HomeCategoryFilter extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final Function(String?) onCategorySelected;

  const HomeCategoryFilter({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final allCategories = ['All', ...categories];
    if (allCategories.length <= 1) return const SizedBox(height: 12);

    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 52,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        itemCount: allCategories.length,
        itemBuilder: (context, index) {
          final cat = allCategories[index];
          final isSelected =
              index == 0 ? selectedCategory == null : selectedCategory == cat;
          final catColor = colorScheme.getCategoryColor(cat);

          return GestureDetector(
            onTap: () => onCategorySelected(index == 0 ? null : cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? catColor : colorScheme.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? catColor : colorScheme.borderColor,
                  width: 1.5,
                ),
                boxShadow:
                    isSelected
                        ? [
                          BoxShadow(
                            color: catColor.withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                        : null,
              ),
              child: Text(
                cat,
                style: TextStyle(
                  color: isSelected ? Colors.white : colorScheme.textTertiary,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
