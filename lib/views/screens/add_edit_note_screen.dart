import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/views/widgets/add_edit_note/note_category_selector.dart';
import 'package:notes_app/views/widgets/add_edit_note/note_color_picker.dart';
import 'package:notes_app/views/widgets/add_edit_note/note_content_field.dart';
import 'package:notes_app/views/widgets/add_edit_note/note_save_button.dart';
import 'package:notes_app/views/widgets/add_edit_note/note_tags_input.dart';
import 'package:notes_app/views/widgets/add_edit_note/note_title_field.dart';
import 'package:notes_app/views/widgets/common/custom_app_bar.dart';
import 'package:notes_app/views/widgets/common/custom_snackbar.dart';
import 'package:notes_app/views/widgets/common/keyboard_dismiss_wrapper.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/notes_viewmodel.dart';

class AddEditNoteScreen extends StatefulWidget {
  final String? noteId;
  const AddEditNoteScreen({super.key, this.noteId});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _selectedCategory;
  List<String> _tags = [];
  int _selectedColorIndex = 0;
  bool _isInitialized = false;

  bool get _isEditing => widget.noteId != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized && _isEditing) {
      _loadExistingNote();
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _loadExistingNote() {
    final vm = context.read<NotesViewModel>();
    final note = vm.getNoteById(widget.noteId!);
    if (note != null) {
      _titleController.text = note.title;
      _contentController.text = note.content;
      _selectedCategory = note.category;
      _tags = note.tags ?? [];
      _selectedColorIndex = note.colorIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = colorScheme.getNoteBorderColor(_selectedColorIndex);

    return KeyboardDismissWrapper(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: _isEditing ? 'Edit Note' : 'New Note',
                subtitle:
                    _isEditing ? 'Make your changes' : 'Capture your thoughts',
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NoteColorPicker(
                          selectedIndex: _selectedColorIndex,
                          onColorSelected: (index) {
                            setState(() => _selectedColorIndex = index);
                          },
                        ),
                        const SizedBox(height: 20),
                        NoteTitleField(
                          titleController: _titleController,
                          borderColor: borderColor,
                        ),
                        const SizedBox(height: 16),
                        NoteContentField(
                          contentController: _contentController,
                          borderColor: borderColor,
                        ),
                        const SizedBox(height: 20),
                        NoteCategorySelector(
                          selectedCategory: _selectedCategory,
                          onCategorySelected: (category) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        NoteTagsInput(
                          tags: _tags,
                          borderColor: borderColor,
                          onTagsChanged: (tags) {
                            setState(() => _tags = tags);
                          },
                        ),
                        const SizedBox(height: 32),
                        NoteSaveButton(
                          isEditing: _isEditing,
                          color: borderColor,
                          onPressed: _saveNote,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveNote() async {
    if (!_formKey.currentState!.validate()) return;

    final vm = context.read<NotesViewModel>();
    bool success;

    if (_isEditing) {
      success = await vm.updateNote(
        id: widget.noteId!,
        title: _titleController.text,
        content: _contentController.text,
        category: _selectedCategory,
        tags: _tags.isEmpty ? null : _tags,
        colorIndex: _selectedColorIndex,
      );
    } else {
      success = await vm.addNote(
        title: _titleController.text,
        content: _contentController.text,
        category: _selectedCategory,
        tags: _tags.isEmpty ? null : _tags,
        colorIndex: _selectedColorIndex,
      );
    }

    if (!mounted) return;

    if (success) {
      CustomSnackbar.showSuccess(
        context,
        _isEditing ? 'Note updated successfully!' : 'Note saved successfully!',
      );
      Navigator.pop(context);
    } else {
      CustomSnackbar.showError(
        context,
        vm.errorMessage ?? 'Something went wrong.',
      );
    }
  }
}
