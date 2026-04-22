import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/app_colors.dart';

class AuthLandingPage extends StatelessWidget {
  const AuthLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/onboarding/auth_cover.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.centerLeft,
            errorBuilder: (_, _, _) {
              return const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.deepBlue,
                      AppColors.mediterraneanBlue,
                      AppColors.olive,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF120A09).withValues(alpha: 0.18),
                    const Color(0xFF230F0E).withValues(alpha: 0.06),
                    const Color(0xFF1A1112).withValues(alpha: 0.36),
                    const Color(0xFF130E10).withValues(alpha: 0.82),
                  ],
                  stops: const [0.0, 0.35, 0.68, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Column(
                        children: [
                          Text(
                            'HKEYETNA',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayMedium
                                ?.copyWith(
                                  color: const Color(0xFFE5E3B0),
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.1,
                                  shadows: const [
                                    Shadow(
                                      color: Color(0x66000000),
                                      blurRadius: 18,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Explore Tunisia in a deeper, more local way',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: const Color(0xFFF7F0E3),
                                  height: 1.35,
                                  shadows: const [
                                    Shadow(
                                      color: Color(0x4D000000),
                                      blurRadius: 12,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _AuthActionButton(
                          label: 'LOG IN',
                          backgroundColor: const Color(0xFF388EA2),
                          foregroundColor: Colors.white,
                          accentColor: const Color(0xFFE5E3B0),
                          onTap: () => context.push('/login'),
                        ),
                        const SizedBox(height: 14),
                        _AuthActionButton(
                          label: 'SIGN UP',
                          backgroundColor: const Color(0xFFF7722F),
                          foregroundColor: Colors.white,
                          accentColor: const Color(0xFFF8BC4A),
                          onTap: () => context.push('/signup'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthActionButton extends StatelessWidget {
  const _AuthActionButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.accentColor,
    required this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            height: 76,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  backgroundColor,
                  Color.lerp(backgroundColor, accentColor, 0.18)!,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor.withValues(alpha: 0.34),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.10),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                const Positioned(top: 8, left: 10, child: _CornerMarks()),
                const Positioned(top: 8, right: 10, child: _CornerMarks()),
                const Positioned(bottom: 8, left: 10, child: _CornerMarks(bottom: true)),
                const Positioned(bottom: 8, right: 10, child: _CornerMarks(bottom: true)),
                Center(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: foregroundColor,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CornerMarks extends StatelessWidget {
  const _CornerMarks({this.bottom = false});

  final bool bottom;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42,
      height: 18,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: bottom ? null : 0,
            bottom: bottom ? 0 : null,
            child: Container(
              width: 28,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF222222),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF222222),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
