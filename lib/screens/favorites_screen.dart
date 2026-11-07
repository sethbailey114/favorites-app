import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/book_row.dart';
import '../widgets/city_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/hobby_row.dart';
import '../widgets/section_header.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoritesProvider>();

    final cities = provider.favoriteCities;
    final hobbies = provider.favoriteHobbies;
    final books = provider.favoriteBooks;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favorites',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: !provider.hasFavorites
                    ? const EmptyState(
                        icon: Icons.favorite_border,
                        title: 'No favorites yet',
                        message:
                            'Tap the heart on any city, hobby, or book in Browse to save it here.',
                      )
                    : ListView(
                        children: [
                          if (cities.isNotEmpty) ...[
                            SectionHeader(
                              title: 'Cities',
                              count: cities.length,
                            ),
                            ...cities.map((city) => CityCard(city: city)),
                          ],
                          if (hobbies.isNotEmpty) ...[
                            SectionHeader(
                              title: 'Hobbies',
                              count: hobbies.length,
                            ),
                            ...hobbies.map((hobby) => HobbyRow(hobby: hobby)),
                          ],
                          if (books.isNotEmpty) ...[
                            SectionHeader(title: 'Books', count: books.length),
                            ...books.map((book) => BookRow(book: book)),
                          ],
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
