import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/repositories/notes_repository.dart';
import 'package:notes_app/viewmodels/sort_option.dart';

class NotesViewModel extends ChangeNotifier {
  final NotesRepository _notesRepository = NotesRepository();

  NotesViewModel(NotesRepository notesRepository) {
    _loadNotes();
  }

  List<Note> _allNotes = [];
  List<Note> _filteredNotes = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  String? _selectedCategory;
  SortOption _sortOption = SortOption.dateNewest;

  // ---- Getters ----
  List<Note> get allNotes => _allNotes;
  List<Note> get notes => _filteredNotes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String? get selectedCategory => _selectedCategory;
  SortOption get sortOption => _sortOption;

  int get totalNotes => _allNotes.length;

  Map<String, int> get categoryStats {
    final Map<String, int> stats = {};
    for (final note in _allNotes) {
      final category = note.category ?? 'None';
      stats[category] = (stats[category] ?? 0) + 1;
    }
    return stats;
  }

  List<String> get allCategories {
    final Set<String> categories = {};
    for (final note in _allNotes) {
      if (note.category != null && note.category!.isNotEmpty) {
        categories.add(note.category!);
      }
    }
    return categories.toList()..sort();
  }

  Note? getNoteById(String id) {
    try {
      return _allNotes.firstWhere((note) => note.id == id);
    } catch (e) {
      return null;
    }
  }

  // ---- Loading Notes ----
  void _loadNotes() {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _allNotes = _notesRepository.getAllNotes();
      _applyFiltersAndSort();
    } catch (e) {
      _errorMessage = 'Failed to load notes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void refreshNotes() => _loadNotes();

  // ----- CRUD Operations -----
  Future<bool> addNote({
    required String title,
    required String content,
    String? category,
    List<String>? tags,
    int colorIndex = 0,
  }) async {
    if (title.trim().isEmpty) {
      _errorMessage = 'Title Cannot Be Empty!';
      notifyListeners();
      return false;
    }
    if (content.trim().isEmpty) {
      _errorMessage = 'Content Cannot Be Empty!';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final now = DateTime.now();
      final note = Note(
        id: now.millisecondsSinceEpoch.toString(),
        title: title.trim(),
        content: content.trim(),
        createdAt: now,
        updatedAt: now,
        category: category?.trim().isEmpty == true ? null : category?.trim(),
        tags: tags,
        colorIndex: colorIndex,
      );
      await _notesRepository.addNote(note);
      _allNotes = _notesRepository.getAllNotes();
      _applyFiltersAndSort();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to add note: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateNote({
    required String id,
    required String title,
    required String content,
    String? category,
    List<String>? tags,
    int colorIndex = 0,
  }) async {
    if (title.trim().isEmpty) {
      _errorMessage = 'Title Cannot Be Empty!';
      notifyListeners();
      return false;
    }
    if (content.trim().isEmpty) {
      _errorMessage = 'Content Cannot Be Empty!';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final existing = _allNotes.firstWhere((n) => n.id == id);
      final updated = Note(
        id: existing.id,
        title: title.trim(),
        content: content.trim(),
        createdAt: existing.createdAt,
        updatedAt: DateTime.now(),
        category: category?.trim().isEmpty == true ? null : category?.trim(),
        tags: tags,
        colorIndex: colorIndex,
      );
      await _notesRepository.updateNote(updated);
      _allNotes = _notesRepository.getAllNotes();
      _applyFiltersAndSort();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update note: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteNote(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _notesRepository.deleteNote(id);
      _allNotes = _notesRepository.getAllNotes();
      _applyFiltersAndSort();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete note: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ---- Filtering, Sorting and Searching ----
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFiltersAndSort();
  }

  void setCategory(String? category) {
    _selectedCategory = category;
    _applyFiltersAndSort();
  }

  void setSortOption(SortOption option) {
    _sortOption = option;
    _applyFiltersAndSort();
  }

  void _applyFiltersAndSort() {
    List<Note> result = List.from(_allNotes);

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      result =
          result
              .where(
                (n) =>
                    n.title.toLowerCase().contains(q) ||
                    n.content.toLowerCase().contains(q) ||
                    (n.tags?.any((t) => t.toLowerCase().contains(q)) ?? false),
              )
              .toList();
    }

    // Filter by category
    if (_selectedCategory != null) {
      result = result.where((n) => n.category == _selectedCategory).toList();
    }

    // Sort
    switch (_sortOption) {
      case SortOption.dateNewest:
        result.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case SortOption.dateOldest:
        result.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
        break;
      case SortOption.titleAZ:
        result.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
      case SortOption.titleZA:
        result.sort(
          (a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()),
        );
        break;
    }

    _filteredNotes = result;
    notifyListeners();
  }
}
