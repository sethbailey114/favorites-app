import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hobby_model.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_theme.dart';
import 'favorite_button.dart';
import 'item_tile.dart';

class HobbyRow extends StatelessWidget {
  final HobbyModel hobby;

  const HobbyRow({super.key, required this.hobby});

  @override
  Widget build(BuildContext context) {
    return ItemTile(
      accent: AppTheme.accentFor(hobby.id),
      // hobbyIcon is an emoji string, so it is drawn as text.
      badge: Text(hobby.hobbyIcon, style: const TextStyle(fontSize: 24)),
      title: hobby.hobbyName,
      trailing: FavoriteButton(
        isFavorite: hobby.isFavorite,
        onPressed: () {
          context.read<FavoritesProvider>().toggleHobbyFavorite(hobby.id);
        },
      ),
    );
  }
}
