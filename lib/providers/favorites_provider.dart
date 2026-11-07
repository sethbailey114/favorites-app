import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/sample_data.dart';
import '../models/book_model.dart';
import '../models/city_model.dart';
import '../models/hobby_model.dart';

class FavoritesProvider extends ChangeNotifier {
  static const String _cityKey = 'favoriteCityIds';
  static const String _hobbyKey = 'favoriteHobbyIds';
  static const String _bookKey = 'favoriteBookIds';
  static const String _darkModeKey = 'isDarkMode';

  final List<CityModel> cities = sampleCities;
  final List<HobbyModel> hobbies = sampleHobbies;
  final List<BookModel> books = sampleBooks;

  bool isDarkMode = false;

  FavoritesProvider() {
    loadFavorites();
  }

  // ---------- Favorite lists (used by the Favorites screen) ----------

  List<CityModel> get favoriteCities =>
      cities.where((c) => c.isFavorite).toList();
  List<HobbyModel> get favoriteHobbies =>
      hobbies.where((h) => h.isFavorite).toList();
  List<BookModel> get favoriteBooks =>
      books.where((b) => b.isFavorite).toList();

  bool get hasFavorites =>
      favoriteCities.isNotEmpty ||
      favoriteHobbies.isNotEmpty ||
      favoriteBooks.isNotEmpty;

  // ---------- Search (used by the Browse screen) ----------

  String _normalize(String query) => query.trim().toLowerCase();

  List<CityModel> searchCities(String query) {
    final q = _normalize(query);
    if (q.isEmpty) return cities;
    return cities.where((c) => c.cityName.toLowerCase().contains(q)).toList();
  }

  List<HobbyModel> searchHobbies(String query) {
    final q = _normalize(query);
    if (q.isEmpty) return hobbies;
    return hobbies.where((h) => h.hobbyName.toLowerCase().contains(q)).toList();
  }

  List<BookModel> searchBooks(String query) {
    final q = _normalize(query);
    if (q.isEmpty) return books;
    return books
        .where(
          (b) =>
              b.bookTitle.toLowerCase().contains(q) ||
              b.bookAuthor.toLowerCase().contains(q),
        )
        .toList();
  }

  // ---------- Saving ----------

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      _cityKey,
      cities.where((c) => c.isFavorite).map((c) => c.id.toString()).toList(),
    );
    await prefs.setStringList(
      _hobbyKey,
      hobbies.where((h) => h.isFavorite).map((h) => h.id.toString()).toList(),
    );
    await prefs.setStringList(
      _bookKey,
      books.where((b) => b.isFavorite).map((b) => b.id.toString()).toList(),
    );
  }

  Future<void> saveDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, isDarkMode);
  }

  // ---------- Loading ----------

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final savedCityIds = prefs.getStringList(_cityKey) ?? [];
    final savedHobbyIds = prefs.getStringList(_hobbyKey) ?? [];
    final savedBookIds = prefs.getStringList(_bookKey) ?? [];

    for (final city in cities) {
      city.isFavorite = savedCityIds.contains(city.id.toString());
    }
    for (final hobby in hobbies) {
      hobby.isFavorite = savedHobbyIds.contains(hobby.id.toString());
    }
    for (final book in books) {
      book.isFavorite = savedBookIds.contains(book.id.toString());
    }

    isDarkMode = prefs.getBool(_darkModeKey) ?? false;

    notifyListeners();
  }

  // ---------- Actions ----------

  void toggleCityFavorite(int id) {
    final city = cities.firstWhere((c) => c.id == id);
    city.isFavorite = !city.isFavorite;
    notifyListeners();
    saveFavorites();
  }

  void toggleHobbyFavorite(int id) {
    final hobby = hobbies.firstWhere((h) => h.id == id);
    hobby.isFavorite = !hobby.isFavorite;
    notifyListeners();
    saveFavorites();
  }

  void toggleBookFavorite(int id) {
    final book = books.firstWhere((b) => b.id == id);
    book.isFavorite = !book.isFavorite;
    notifyListeners();
    saveFavorites();
  }

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
    saveDarkMode();
  }

  void clearFavorites() {
    for (final city in cities) {
      city.isFavorite = false;
    }
    for (final hobby in hobbies) {
      hobby.isFavorite = false;
    }
    for (final book in books) {
      book.isFavorite = false;
    }
    notifyListeners();
    saveFavorites();
  }
}
