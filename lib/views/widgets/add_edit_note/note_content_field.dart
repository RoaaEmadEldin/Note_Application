import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/views/widgets/common/section_label.dart';

class NoteContentField extends StatelessWidget {
  final TextEditingController contentController;
  final Color borderColor;

  const NoteContentField({
    super.key,
    required this.contentController,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(text: 'Content'),
        const SizedBox(height: 8),
        TextFormField(
          controller: contentController,
          maxLines: 8,
          minLines: 5,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Poppins',
            height: 1.6,
            color: colorScheme.textSecondary,
          ),
          decoration: InputDecoration(
            hintText: 'Write your note here...',
            filled: true,
            fillColor: colorScheme.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: colorScheme.borderColor,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            contentPadding: const EdgeInsets.all(20),
            alignLabelWithHint: true,
          ),
          validator:
              (v) =>
                  v == null || v.trim().isEmpty ? 'Content is required' : null,
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }
}
