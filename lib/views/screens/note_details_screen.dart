import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/views/widgets/common/confirm_dialog.dart';
import 'package:notes_app/views/widgets/common/custom_snackbar.dart';
import 'package:notes_app/views/widgets/common/keyboard_dismiss_wrapper.dart';
import 'package:notes_app/views/widgets/note_details/note_details_content.dart';
import 'package:notes_app/views/widgets/note_details/note_details_meta_info.dart';
import 'package:notes_app/views/widgets/note_details/note_details_app_bar.dart';
import 'package:notes_app/views/widgets/note_details/note_details_header.dart';
import 'package:notes_app/views/widgets/note_details/note_details_tags.dart';
import 'package:notes_app/views/widgets/note_details/note_not_found.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/notes_viewmodel.dart';

class NoteDetailsScreen extends StatelessWidget {
  final String noteId;
  const NoteDetailsScreen({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NotesViewModel>();
    final note = vm.getNoteById(noteId);
    final theme = Theme.of(context);

    if (note == null) {
      return NoteNotFound(onBackPressed: () => Navigator.pop(context));
    }

    final colorScheme = theme.colorScheme;
    final borderColor = colorScheme.getNoteBorderColor(note.colorIndex);
    final bgColor = colorScheme.getNoteColor(note.colorIndex);

    return KeyboardDismissWrapper(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              NoteDetailsAppBar(
                note: note,
                borderColor: borderColor,
                onDelete: () => _deleteNote(context, vm),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NoteDetailsHeader(
                        borderColor: borderColor,
                        title: note.title,
                      ),
                      const SizedBox(height: 12),
                      NoteDetailsMetaInfo(note: note),
                      const SizedBox(height: 24),
                      NoteDetailsContent(
                        content: note.content,
                        bgColor: bgColor,
                        borderColor: borderColor,
                      ),
                      // Tags
                      if (note.tags != null && note.tags!.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        NoteDetailsTags(
                          tags: note.tags!,
                          borderColor: borderColor,
                        ),
                      ],
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteNote(BuildContext context, NotesViewModel vm) async {
    final confirm = await confirmDialog(
      context: context,
      title: 'Delete Note?',
      message:
          'Are you sure you want to delete this note? This action cannot be undone.',
      confirmButtonText: 'Delete',
    );

    if (confirm == true) {
      await vm.deleteNote(noteId);
      if (context.mounted) {
        CustomSnackbar.showSuccess(context, 'Note deleted successfully!');
        Navigator.pop(context);
      }
    }
  }
}
