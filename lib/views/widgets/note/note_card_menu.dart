import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/views/screens/add_edit_note_screen.dart';
import 'package:notes_app/views/widgets/common/confirm_dialog.dart';

class NoteCardMenu extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;

  const NoteCardMenu({super.key, required this.note, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_horiz_rounded,
        color: colorScheme.textDisabled,
        size: 20,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: colorScheme.surfaceContainerHighest,
      elevation: 8,
      offset: const Offset(0, 8),
      itemBuilder:
          (_) => [
            _buildMenuItem(
              'edit',
              Icons.edit_rounded,
              'Edit',
              colorScheme.primary,
              colorScheme,
            ),
            _buildMenuItem(
              'delete',
              Icons.delete_rounded,
              'Delete',
              colorScheme.error,
              colorScheme,
            ),
          ],
      onSelected: (value) => _handelMenuAction(context, value),
    );
  }

  PopupMenuItem<String> _buildMenuItem(
    String value,
    IconData icon,
    String label,
    Color color,
    ColorScheme colorScheme,
  ) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: value == 'delete' ? color : colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handelMenuAction(BuildContext context, String value) async {
    if (value == 'edit') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => AddEditNoteScreen(noteId: note.id)),
      );
    } else if (value == 'delete') {
      final confirm = await confirmDialog(
        context: context,
        title: 'Delete Note?',
        message:
            'Are you sure you want to delete this note? This action cannot be undone.',
        confirmButtonText: 'Delete',
      );
      if (confirm == true) onDelete();
    }
  }
}
