import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class RatingBadge extends StatelessWidget {
  const RatingBadge({required this.rating, this.compact = false, super.key});

  final double rating;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: AppColors.warning, size: 16),
          const SizedBox(width: 4),
          Text(rating.toStringAsFixed(1)),
        ],
      ),
    );
  }
}
