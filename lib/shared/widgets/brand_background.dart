import 'package:flutter/material.dart';

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
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/onboarding/auth_cover.jpg',
          fit: BoxFit.cover,
          alignment: Alignment.center,
          errorBuilder: (_, _, _) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7B1710), Color(0xFF432320)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            );
          },
        ),
        Container(color: Colors.black.withValues(alpha: 0.42)),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withValues(alpha: 0.06),
                const Color(0x4D5A3F39),
                const Color(0x8C2C201E),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        if (topGlow)
          Positioned(
            top: -120,
            right: -80,
            child: _GlowOrb(
              size: 320,
              colors: [
                Colors.white.withValues(alpha: 0.12),
                Colors.transparent,
              ],
            ),
          ),
        Positioned(
          bottom: -120,
          left: -60,
          child: _GlowOrb(
            size: 280,
            colors: [
              const Color(0xFF0E7C8D).withValues(alpha: 0.18),
              Colors.transparent,
            ],
          ),
        ),
        Positioned.fill(
          child: Padding(padding: padding, child: child),
        ),
      ],
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
