import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class BrandBackground extends StatelessWidget {
  const BrandBackground({
    required this.child,
    this.padding = EdgeInsets.zero,
    this.topGlow = true,
    super.key,
  });

  final Widget child;
  final EdgeInsets padding;
  final bool topGlow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.offWhite, Color(0xFFF7F2E8), Color(0xFFFDF9F3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (topGlow)
            Positioned(
              top: -120,
              left: -60,
              child: _GlowOrb(
                size: 280,
                colors: [
                  AppColors.sky.withValues(alpha: 0.22),
                  Colors.transparent,
                ],
              ),
            ),
          Positioned(
            top: 40,
            right: -40,
            child: _GlowOrb(
              size: 220,
              colors: [
                AppColors.sandDark.withValues(alpha: 0.32),
                Colors.transparent,
              ],
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _DotGridPainter()),
            ),
          ),
          Positioned.fill(
            child: Padding(padding: padding, child: child),
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.colors});

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: colors),
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.deepBlue.withValues(alpha: 0.045)
      ..style = PaintingStyle.fill;

    const spacing = 22.0;
    const radius = 1.1;

    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
