import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book_model.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_theme.dart';
import 'book_cover.dart';
import 'favorite_button.dart';

class BookRow extends StatelessWidget {
  final BookModel book;

  const BookRow({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final accent = AppTheme.accentFor(book.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: colors.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: accent.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            BookCover(title: book.bookTitle, color: accent),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book.bookTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 15,
                        color: colors.outline,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          book.bookAuthor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: colors.outline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FavoriteButton(
              isFavorite: book.isFavorite,
              onPressed: () {
                context.read<FavoritesProvider>().toggleBookFavorite(book.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
