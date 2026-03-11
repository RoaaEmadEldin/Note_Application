import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';

class HomeSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const HomeSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  bool _isExpanded = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isExpanded ? colorScheme.primary : colorScheme.borderColor,
            width: _isExpanded ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          onTap: () => setState(() => _isExpanded = true),
          onTapOutside: (_) {
            setState(() => _isExpanded = false);
            _focusNode.unfocus();
          },
          onChanged: widget.onChanged,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: 'Search notes, tags...',
            hintStyle: TextStyle(
              color: colorScheme.textDisabled,
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color:
                  _isExpanded ? colorScheme.primary : colorScheme.textDisabled,
              size: 22,
            ),
            suffixIcon:
                widget.controller.text.isNotEmpty
                    ? GestureDetector(
                      onTap: () {
                        widget.controller.clear();
                        widget.onChanged('');
                        setState(() {
                          _isExpanded = false;
                        });
                        _focusNode.unfocus();
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: colorScheme.textDisabled,
                        size: 20,
                      ),
                    )
                    : null,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            filled: false,
          ),
        ),
      ),
    );
  }
}
