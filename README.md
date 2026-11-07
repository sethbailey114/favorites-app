# Favorites App

A Flutter app for browsing and saving favorite cities, hobbies, and books.

## Features
- Browse tab with Cities, Hobbies, and Books categories and live search
- Favorite and unfavorite items from any category (animated heart)
- Favorites tab showing all favorites grouped by category; items can be removed there
- Settings tab with a dark mode switch and a Clear Favorites button with confirmation
- Favorites and theme preference saved locally with shared_preferences
- Shared state managed with Provider

## Running
    flutter pub get
    flutter run -d web-server --web-port 8080

Then open http://localhost:8080 in a regular browser. Using a fixed port and a
normal browser profile keeps web local storage between launches. On Android or
Windows, `flutter run` works as usual.