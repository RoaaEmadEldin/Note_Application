import 'package:flutter/material.dart';
import 'package:notes_app/views/widgets/common/section_label.dart';

class NoteDetailsTags extends StatelessWidget {
  final List<String> tags;
  final Color borderColor;

  const NoteDetailsTags({
    super.key,
    required this.tags,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(text: 'TAGS'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              tags
                  .map((tag) => _TagChip(tag: tag, borderColor: borderColor))
                  .toList(),
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final String tag;
  final Color borderColor;

  const _TagChip({required this.tag, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: borderColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        '#$tag',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: borderColor,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
