import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/item_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _confirmClear(BuildContext context) {
    final provider = context.read<FavoritesProvider>();
    final messenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.delete_outline,
            color: AppTheme.coral,
            size: 32,
          ),
          title: const Text('Clear all favorites?'),
          content: const Text(
            'This will remove every saved favorite from all categories. '
            'This cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppTheme.coral),
              onPressed: () {
                provider.clearFavorites();
                Navigator.of(dialogContext).pop();
                messenger.showSnackBar(
                  const SnackBar(content: Text('All favorites cleared')),
                );
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoritesProvider>();
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              ItemTile(
                accent: AppTheme.violet,
                badge: const Icon(Icons.dark_mode, color: Colors.white),
                title: 'Dark Mode',
                subtitle: 'Use a dark color theme',
                onTap: () => provider.toggleDarkMode(!provider.isDarkMode),
                trailing: Switch(
                  value: provider.isDarkMode,
                  onChanged: provider.toggleDarkMode,
                ),
              ),
              ItemTile(
                accent: provider.hasFavorites
                    ? AppTheme.coral
                    : theme.colorScheme.outline,
                badge: const Icon(Icons.delete_outline, color: Colors.white),
                title: 'Clear Favorites',
                subtitle: provider.hasFavorites
                    ? 'Remove all saved favorites'
                    : 'No favorites to clear',
                onTap: provider.hasFavorites
                    ? () => _confirmClear(context)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
