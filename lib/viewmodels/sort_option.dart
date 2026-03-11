import 'package:flutter/material.dart';

enum SortOption { dateNewest, dateOldest, titleAZ, titleZA }

extension SortOptionExtension on SortOption {
  String get displayName {
    switch (this) {
      case SortOption.dateNewest:
        return 'Newest';
      case SortOption.dateOldest:
        return 'Oldest';
      case SortOption.titleAZ:
        return 'A → Z';
      case SortOption.titleZA:
        return 'Z → A';
    }
  }

  String get displayFullName{
    switch (this) {
      case SortOption.dateNewest:
        return 'Newest first';
      case SortOption.dateOldest:
        return 'Oldest first';
      case SortOption.titleAZ:
        return 'Title A → Z';
      case SortOption.titleZA:
        return 'Title Z → A';
    }
  }

  IconData get icon{
    switch (this) {
      case SortOption.dateNewest:
        return Icons.arrow_downward_rounded;
      case SortOption.dateOldest:
        return Icons.arrow_upward_rounded;
      case SortOption.titleAZ:
        return Icons.sort_by_alpha_rounded;
      case SortOption.titleZA:
        return Icons.sort_by_alpha_rounded;
    }
  }
}
