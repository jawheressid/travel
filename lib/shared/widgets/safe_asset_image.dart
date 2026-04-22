import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class SafeAssetImage extends StatelessWidget {
  const SafeAssetImage({
    required this.path,
    required this.title,
    this.height,
    this.borderRadius = 24,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    super.key,
  });

  final String path;
  final String title;
  final double? height;
  final double borderRadius;
  final BoxFit fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: const LinearGradient(
          colors: [
            AppColors.deepBlue,
            AppColors.mediterraneanBlue,
            AppColors.olive,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );

    if (path.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          path,
          height: height,
          width: double.infinity,
          fit: fit,
          alignment: alignment,
          errorBuilder: (_, _, _) => placeholder,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        path,
        height: height,
        width: double.infinity,
        fit: fit,
        alignment: alignment,
        errorBuilder: (_, _, _) => placeholder,
      ),
    );
  }
}
