import 'package:flutter/material.dart';

/// A small book cover drawn in code: gradient, darker spine, big serif initial.
class BookCover extends StatelessWidget {
  final String title;
  final Color color;
  final double width;
  final double height;

  const BookCover({
    super.key,
    required this.title,
    required this.color,
    this.width = 56,
    this.height = 80,
  });

  /// First meaningful letter: "The Hobbit" -> "H", "1984" -> "1".
  String get _initial {
    var text = title.trim();
    for (final article in ['The ', 'A ', 'An ']) {
      if (text.startsWith(article)) {
        text = text.substring(article.length);
        break;
      }
    }
    return text.isEmpty ? '?' : text[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final darker = Color.lerp(color, Colors.black, 0.35)!;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(3),
          bottomLeft: Radius.circular(3),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, darker],
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 3)),
        ],
      ),
      child: Row(
        children: [
          // Spine
          Container(
            width: 7,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(3),
                bottomLeft: Radius.circular(3),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                _initial,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                  fontFamilyFallback: ['Georgia', 'Times New Roman'],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
