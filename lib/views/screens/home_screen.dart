import 'package:flutter/material.dart';
import 'package:notes_app/views/screens/note_details_screen.dart';
import 'package:notes_app/views/widgets/common/keyboard_dismiss_wrapper.dart';
import 'package:notes_app/views/widgets/home/home_category_filter.dart';
import 'package:notes_app/views/widgets/home/home_empty_state.dart';
import 'package:notes_app/views/widgets/home/home_header.dart';
import 'package:notes_app/views/widgets/home/home_search_bar.dart';
import 'package:notes_app/views/widgets/home/home_sort_bar.dart';
import 'package:notes_app/views/widgets/common/loading_indicator.dart';
import 'package:notes_app/views/widgets/note/note_card.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/notes_viewmodel.dart';
import 'add_edit_note_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NotesViewModel>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return KeyboardDismissWrapper(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                viewModel: vm,
                onSettingsTap: () => _navigateToSettings(context),
              ),
              HomeSearchBar(
                controller: _searchController,
                onChanged: vm.setSearchQuery,
              ),
              HomeCategoryFilter(
                categories: vm.allCategories,
                selectedCategory: vm.selectedCategory,
                onCategorySelected: vm.setCategory,
              ),
              HomeSortBar(
                totalNotes: vm.totalNotes,
                filteredCount: vm.notes.length,
                isFiltered:
                    vm.searchQuery.isNotEmpty || vm.selectedCategory != null,
                currentSort: vm.sortOption,
                onSortChanged: vm.setSortOption,
              ),
              Expanded(
                child:
                    vm.isLoading
                        ? const LoadingIndicator(message: 'Loading notes...')
                        : vm.notes.isEmpty
                        ? HomeEmptyState(
                          isFiltered:
                              vm.searchQuery.isNotEmpty ||
                              vm.selectedCategory != null,
                          onClearFilters: _clearFilters(vm),
                        )
                        : _buildNotesList(vm),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _navigateToAddNote(context),
          icon: const Icon(Icons.add_rounded, size: 24),
          label: const Text(
            'New Note',
            style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildNotesList(NotesViewModel vm) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      itemCount: vm.notes.length,
      itemBuilder: (context, index) {
        final note = vm.notes[index];
        return NoteCard(
          note: note,
          onDelete: () => vm.deleteNote(note.id),
          onTap: () => _navigateToNoteDetails(context, note.id),
        );
      },
    );
  }

  // --- Helpers ---
  VoidCallback _clearFilters(NotesViewModel vm) {
    return () {
      _searchController.clear();
      vm.setSearchQuery('');
      vm.setCategory(null);
    };
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  void _navigateToAddNote(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditNoteScreen()),
    );
  }

  void _navigateToNoteDetails(BuildContext context, String noteId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NoteDetailsScreen(noteId: noteId)),
    );
  }
}
