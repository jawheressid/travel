import 'package:flutter/material.dart';

import '../../core/enums/app_enums.dart';
import '../../core/models/place.dart';
import '../../core/utils/formatters.dart';
import 'rating_badge.dart';
import 'safe_asset_image.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    required this.place,
    required this.onTap,
    this.onFavoriteToggle,
    this.isFavorite = false,
    this.subtitle,
    super.key,
  });

  final Place place;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;
  final bool isFavorite;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Ink(
        width: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SafeAssetImage(
                  path: place.imageUrl,
                  title: place.name,
                  height: 180,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Row(
                    children: [
                      RatingBadge(rating: place.rating, compact: true),
                      if (onFavoriteToggle != null) ...[
                        const SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: Colors.white.withValues(alpha: 0.92),
                          child: IconButton(
                            onPressed: onFavoriteToggle,
                            iconSize: 18,
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle ?? place.shortDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${place.type.label} - ${formatCurrency(place.priceMin)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
