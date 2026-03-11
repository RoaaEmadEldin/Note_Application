import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/views/widgets/common/custom_icon_button.dart';
import '../../../models/note.dart';
import '../../screens/add_edit_note_screen.dart';

class NoteDetailsAppBar extends StatelessWidget {
  final Note note;
  final Color borderColor;
  final VoidCallback onDelete;

  const NoteDetailsAppBar({
    super.key,
    required this.note,
    required this.borderColor,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          CustomIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            color: colorScheme.primary,
            bgColor: colorScheme.cardBackground,
            onTap: () => Navigator.pop(context),
          ),
          const Spacer(),
          CustomIconButton(
            icon: Icons.edit_rounded,
            color: Colors.white,
            bgColor: colorScheme.primary,
            onTap: () => _navigateToEditScreen(context),
          ),
          const SizedBox(width: 8),
          CustomIconButton(
            icon: Icons.delete_rounded,
            color: Colors.white,
            bgColor: colorScheme.error,
            onTap: onDelete,
          ),
        ],
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditNoteScreen(noteId: note.id),
      ),
    );
  }
}
