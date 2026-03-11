import 'package:flutter/material.dart';
import 'package:notes_app/config/color_scheme_extensions.dart';
import 'package:notes_app/viewmodels/theme_viewmodel.dart';
import 'package:notes_app/views/widgets/common/app_branding_widget.dart';
import 'package:notes_app/views/widgets/common/confirm_dialog.dart';
import 'package:notes_app/views/widgets/common/custom_app_bar.dart';
import 'package:notes_app/views/widgets/common/custom_snackbar.dart';
import 'package:notes_app/views/widgets/common/keyboard_dismiss_wrapper.dart';
import 'package:notes_app/views/widgets/settings/settings_danger_tile.dart';
import 'package:notes_app/views/widgets/settings/settings_info_tile.dart';
import 'package:notes_app/views/widgets/settings/settings_section_header.dart';
import 'package:notes_app/views/widgets/settings/settings_statistics_grid.dart';
import 'package:notes_app/views/widgets/settings/settings_theme_switcher.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/notes_viewmodel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final themeVM = context.watch<ThemeViewModel>();
    final notesVM = context.watch<NotesViewModel>();

    return KeyboardDismissWrapper(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: 'Settings',
                subtitle: 'Customize your experience',
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Appearance Section ---
                      SettingsSectionHeader(
                        title: 'Appearance',
                        icon: Icons.palette_rounded,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      SettingsThemeSwitcher(viewModel: themeVM),
                      const SizedBox(height: 28),
      
                      // --- Statistics Section ---
                      SettingsSectionHeader(
                        title: 'Statistics',
                        icon: Icons.bar_chart_rounded,
                        color: colorScheme.tertiary,
                      ),
                      const SizedBox(height: 12),
                      SettingsStatisticsGrid(viewModel: notesVM),
                      const SizedBox(height: 28),
      
                      // --- Data Section ---
                      SettingsSectionHeader(
                        title: 'Data',
                        icon: Icons.storage_rounded,
                        color: colorScheme.warning,
                      ),
                      const SizedBox(height: 12),
                      SettingsInfoTile(
                        icon: Icons.folder_rounded,
                        iconColor: colorScheme.warning,
                        title: 'Storage',
                        subtitle: 'All notes are stored locally',
                        isStatsTile: false,
                      ),
                      const SizedBox(height: 10),
                      SettingsInfoTile(
                        icon: Icons.category_rounded,
                        iconColor: colorScheme.primary,
                        title: 'Categories',
                        subtitle:
                            notesVM.allCategories.isEmpty
                                ? 'No categories used yet'
                                : notesVM.allCategories.join(' · '),
                        isStatsTile: false,
                      ),
                      const SizedBox(height: 10),
                      SettingsDangerTile(
                        icon: Icons.delete_sweep_rounded,
                        title: 'Clear All Notes',
                        subtitle: 'Permanently delete all saved notes',
                        onTap: () => _confirmClearAll(context, notesVM),
                      ),
                      const SizedBox(height: 28),
      
                      // --- About Section ---
                      SettingsSectionHeader(
                        title: 'About',
                        icon: Icons.info_outline_rounded,
                        color: colorScheme.secondary,
                      ),
                      const SizedBox(height: 12),
                      SettingsInfoTile(
                        icon: Icons.note_alt_rounded,
                        iconColor: colorScheme.primary,
                        title: 'Notes App',
                        subtitle: 'Version 1.0.0',
                        isStatsTile: false,
                      ),
                      const SizedBox(height: 10),
                      SettingsInfoTile(
                        icon: Icons.security_rounded,
                        iconColor: colorScheme.tertiary,
                        title: 'Privacy',
                        subtitle: 'No data is sent to any server',
                        isStatsTile: false,
                      ),
      
                      const SizedBox(height: 40),
                      const AppBrandingWidget(),
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

  Future<void> _confirmClearAll(BuildContext context, NotesViewModel vm) async {
    final confirm = await confirmDialog(
      context: context,
      title: 'Clear All Notes?',
      message:
          'This will permanently clear ALL your notes. This action cannot be undone.',
      confirmButtonText: 'Clear All',
    );

    if (confirm == true && context.mounted) {
      final ids = vm.allNotes.map((n) => n.id).toList();
      for (final id in ids) {
        await vm.deleteNote(id);
      }

      if (context.mounted) {
        CustomSnackbar.showSuccess(context, 'All Notes are Cleared!');
      }
    }
  }
}
