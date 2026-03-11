import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/views/widgets/common/section_label.dart';

class NoteColorPicker extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onColorSelected;

  const NoteColorPicker({
    super.key,
    required this.selectedIndex,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColors = colorScheme.noteBorderColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(text: 'Note Color'),
        const SizedBox(height: 10),
        SizedBox(
          height: 42,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: borderColors.length,
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              final color = borderColors[index];

              return GestureDetector(
                onTap: () => onColorSelected(index),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: isSelected ? 42 : 36,
                  height: isSelected ? 42 : 36,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border:
                        isSelected ? Border.all(color: color, width: 3) : null,
                    boxShadow:
                        isSelected
                            ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.4),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                            : null,
                  ),
                  child:
                      isSelected
                          ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 18,
                          )
                          : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
