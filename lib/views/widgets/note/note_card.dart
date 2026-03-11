import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/views/widgets/common/confirm_dialog.dart';
import 'package:notes_app/views/widgets/note/note_card_menu.dart';
import 'package:notes_app/views/widgets/note/note_category_tag_chip.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final bool showDismissible;

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onTap,
    this.showDismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = colorScheme.getNoteColor(note.colorIndex);
    final borderColor = colorScheme.getNoteBorderColor(note.colorIndex);
    final categoryColor = colorScheme.getCategoryColor(note.category);

    final cardContent = GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border(left: BorderSide(color: borderColor, width: 4)),
          boxShadow: [
            BoxShadow(
              color: borderColor.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(colorScheme),
              const SizedBox(height: 8),
              _buildContent(colorScheme),
              const SizedBox(height: 12),
              _buildFooter(colorScheme, categoryColor, borderColor),
            ],
          ),
        ),
      ),
    );

    if (!showDismissible) return cardContent;

    return Dismissible(
      key: Key(note.id),
      direction: DismissDirection.endToStart,
      background: _DismissBackground(),
      confirmDismiss:
          (_) => confirmDialog(
            context: context,
            title: 'Delete Note?',
            message:
                'Are you sure you want to delete this note? This action cannot be undone.',
            confirmButtonText: 'Delete',
          ),
      onDismissed: (_) => onDelete(),
      child: cardContent,
    );
  }

  Widget _buildHeader(ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            note.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              fontFamily: 'Poppins',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        NoteCardMenu(note: note, onDelete: onDelete),
      ],
    );
  }

  Widget _buildContent(ColorScheme colorScheme) {
    return Text(
      note.content,
      style: TextStyle(
        fontSize: 13,
        color: colorScheme.textSecondary,
        height: 1.5,
        fontFamily: 'Poppins',
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildFooter(
    ColorScheme colorScheme,
    Color categoryColor,
    Color borderColor,
  ) {
    return Row(
      children: [
        if (note.category != null && note.category!.isNotEmpty) ...[
          NoteCategoryTagChip(label: note.category!, color: categoryColor),
          const SizedBox(width: 8),
        ],
        // Tags
        if (note.tags != null && note.tags!.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    note.tags!
                        .take(3)
                        .map(
                          (tag) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: NoteCategoryTagChip(
                              label: tag,
                              color: borderColor,
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        const Spacer(),
        Text(
          _formatDate(note.updatedAt),
          style: TextStyle(
            fontSize: 11,
            color: colorScheme.textDisabled,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else if (difference.inDays < 7) {
      if (difference.inDays == 1) return 'Yesterday';
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class _DismissBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: colorScheme.error,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.delete_rounded, color: Colors.white, size: 28),
          const SizedBox(height: 4),
          const Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
