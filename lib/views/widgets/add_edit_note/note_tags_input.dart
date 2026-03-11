import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/views/widgets/add_edit_note/removable_tag.dart';
import 'package:notes_app/views/widgets/common/section_label.dart';
import 'package:notes_app/views/widgets/common/custom_icon_button.dart';

class NoteTagsInput extends StatefulWidget {
  final List<String> tags;
  final Color borderColor;
  final Function(List<String>) onTagsChanged;

  const NoteTagsInput({
    super.key,
    required this.tags,
    required this.borderColor,
    required this.onTagsChanged,
  });

  @override
  State<NoteTagsInput> createState() => _NoteTagsInputState();
}

class _NoteTagsInputState extends State<NoteTagsInput> {
  final _tagsController = TextEditingController();

  @override
  void dispose() {
    _tagsController.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    final trimmedTag = tag.trim().toLowerCase().replaceAll(' ', '-');
    if (trimmedTag.isNotEmpty && !widget.tags.contains(trimmedTag)) {
      final updatedTags = [...widget.tags, trimmedTag];
      widget.onTagsChanged(updatedTags);
    }
    _tagsController.clear();
  }

  void _removeTag(String tag) {
    final updatedTags = widget.tags.where((t) => t != tag).toList();
    widget.onTagsChanged(updatedTags);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(text: 'Tags'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _tagsController,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: 'Add a tag...',
                  filled: true,
                  fillColor: colorScheme.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.borderColor,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: widget.borderColor, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  prefixIcon: Icon(
                    Icons.tag_rounded,
                    size: 18,
                    color: colorScheme.textDisabled,
                  ),
                ),
                onSubmitted: _addTag,
                textCapitalization: TextCapitalization.none,
              ),
            ),
            const SizedBox(width: 10),
            CustomIconButton(
              icon: Icons.add_rounded,
              color: Colors.white,
              bgColor: colorScheme.primary,
              onTap: () => _addTag(_tagsController.text),
            ),
          ],
        ),
        if (widget.tags.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                widget.tags
                    .map(
                      (tag) => RemovableTag(
                        tag: tag,
                        color: widget.borderColor,
                        onRemove: () => _removeTag(tag),
                      ),
                    )
                    .toList(),
          ),
        ],
      ],
    );
  }
}
