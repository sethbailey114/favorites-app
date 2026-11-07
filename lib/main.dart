import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/content_view.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FavoritesApp());
}

class FavoritesApp extends StatelessWidget {
  const FavoritesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          return MaterialApp(
            title: 'Favorites',
            debugShowCheckedModeBanner: false,
            themeMode: favoritesProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            home: const ContentView(),
          );
        },
      ),
    );
  }
}
