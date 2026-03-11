import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/views/widgets/common/section_label.dart';

class NoteCategorySelector extends StatelessWidget {
  final String? selectedCategory;
  final Function(String?) onCategorySelected;

  const NoteCategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const _categories = [
    'Personal',
    'Work',
    'Ideas',
    'Important',
    'Study',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(text: 'Category'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _CategoryChip(
              category: null,
              isSelected: selectedCategory == null,
              onTap: () => onCategorySelected(null),
            ),
            ..._categories.map(
              (cat) => _CategoryChip(
                category: cat,
                isSelected: selectedCategory == cat,
                onTap: () => onCategorySelected(cat),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String? category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final categoryColor = colorScheme.getCategoryColor(category);
    final label = category ?? 'None';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? categoryColor.withValues(alpha: 0.15)
                  : colorScheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? categoryColor : colorScheme.borderColor,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: 14,
                  color: categoryColor,
                ),
              ),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? categoryColor : colorScheme.textTertiary,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
