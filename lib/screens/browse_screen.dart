import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/book_row.dart';
import '../widgets/city_card.dart';
import '../widgets/empty_state.dart';
import '../widgets/hobby_row.dart';

enum ContentCategory { cities, hobbies, books }

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  ContentCategory selectedCategory = ContentCategory.cities;
  String searchText = '';

  String get searchHint {
    switch (selectedCategory) {
      case ContentCategory.cities:
        return 'Search cities';
      case ContentCategory.hobbies:
        return 'Search hobbies';
      case ContentCategory.books:
        return 'Search books';
    }
  }

  Widget _noResults() {
    return EmptyState(
      icon: Icons.search_off,
      title: 'No results',
      message:
          'Nothing matches "${searchText.trim()}". Try a different search.',
    );
  }

  Widget _buildContent(FavoritesProvider provider) {
    switch (selectedCategory) {
      case ContentCategory.cities:
        final cities = provider.searchCities(searchText);
        if (cities.isEmpty) return _noResults();
        return ListView.builder(
          itemCount: cities.length,
          itemBuilder: (context, index) => CityCard(city: cities[index]),
        );
      case ContentCategory.hobbies:
        final hobbies = provider.searchHobbies(searchText);
        if (hobbies.isEmpty) return _noResults();
        return ListView.builder(
          itemCount: hobbies.length,
          itemBuilder: (context, index) => HobbyRow(hobby: hobbies[index]),
        );
      case ContentCategory.books:
        final books = provider.searchBooks(searchText);
        if (books.isEmpty) return _noResults();
        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) => BookRow(book: books[index]),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<ContentCategory>(
                  segments: const [
                    ButtonSegment(
                      value: ContentCategory.cities,
                      label: Text('Cities'),
                      icon: Icon(Icons.location_city),
                    ),
                    ButtonSegment(
                      value: ContentCategory.hobbies,
                      label: Text('Hobbies'),
                      icon: Icon(Icons.sports_esports),
                    ),
                    ButtonSegment(
                      value: ContentCategory.books,
                      label: Text('Books'),
                      icon: Icon(Icons.menu_book),
                    ),
                  ],
                  selected: {selectedCategory},
                  onSelectionChanged: (selection) {
                    setState(() {
                      selectedCategory = selection.first;
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: searchHint,
                  filled: true,
                  fillColor: colors.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              Expanded(child: _buildContent(favoritesProvider)),
            ],
          ),
        ),
      ),
    );
  }
}
