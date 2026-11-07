import 'package:flutter/material.dart';

/// Heart button shared by every category so they all look and behave alike.
/// Tapping it swaps the icon with a small "pop" animation.
class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  /// Overrides the icon color (used on top of photos, where white reads best).
  final Color? color;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color? iconColor =
        color ?? (isFavorite ? Theme.of(context).colorScheme.secondary : null);

    return IconButton(
      onPressed: onPressed,
      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        switchInCurve: Curves.elasticOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        // The key tells AnimatedSwitcher that the filled and outlined hearts
        // are different widgets, so it animates between them.
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          key: ValueKey<bool>(isFavorite),
          color: iconColor,
        ),
      ),
    );
  }
}
