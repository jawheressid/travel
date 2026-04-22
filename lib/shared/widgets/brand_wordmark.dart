import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class BrandWordmark extends StatelessWidget {
  const BrandWordmark({this.compact = false, this.light = false, super.key});

  final bool compact;
  final bool light;

  @override
  Widget build(BuildContext context) {
    final color = light ? Colors.white : AppColors.deepBlue;
    return Image.asset(
      'assets/images/hkeyetna1.png',
      height: compact ? 38 : 48,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) {
        return Text(
          'HKEYETNA',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        );
      },
    );
  }
}
