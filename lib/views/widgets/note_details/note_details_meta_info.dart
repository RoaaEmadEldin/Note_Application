import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/models/note.dart';

class NoteDetailsMetaInfo extends StatelessWidget {
  final Note note;

  const NoteDetailsMetaInfo({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final categoryColor = colorScheme.getCategoryColor(note.category);

    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: [
        // Category
        if (note.category != null && note.category!.isNotEmpty)
          _MetaChip(
            icon: Icons.folder_rounded,
            label: note.category!,
            color: categoryColor,
          ),
        // Date created
        _MetaChip(
          icon: Icons.calendar_today_rounded,
          label: DateFormat('MMM d, yyyy').format(note.createdAt),
          color: colorScheme.primary,
        ),
        // Date updated
        if (note.updatedAt != note.createdAt)
          _MetaChip(
            icon: Icons.edit_calendar_rounded,
            label: 'Updated ${DateFormat('MMM d').format(note.updatedAt)}',
            color: colorScheme.tertiary,
          ),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
