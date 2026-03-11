import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import '../../../viewmodels/theme_viewmodel.dart';

class SettingsThemeSwitcher extends StatelessWidget {
  final ThemeViewModel viewModel;

  const SettingsThemeSwitcher({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final options = [
      (ThemeMode.light, Icons.wb_sunny_rounded, 'Light'),
      (ThemeMode.dark, Icons.nightlight_round, 'Dark'),
      (ThemeMode.system, Icons.settings_brightness_rounded, 'System'),
    ];

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colorScheme.borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children:
            options.map((opt) {
              final (mode, icon, label) = opt;
              final isSelected = viewModel.themeMode == mode;

              return Expanded(
                child: GestureDetector(
                  onTap: () => viewModel.setThemeMode(mode),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient:
                          isSelected
                              ? LinearGradient(
                                colors: [
                                  colorScheme.primary,
                                  colorScheme.primary.withValues(alpha: 0.8),
                                ],
                              )
                              : null,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.35,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                              : null,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          size: 22,
                          color:
                              isSelected
                                  ? Colors.white
                                  : colorScheme.textDisabled,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                            color:
                                isSelected
                                    ? Colors.white
                                    : colorScheme.textDisabled,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
