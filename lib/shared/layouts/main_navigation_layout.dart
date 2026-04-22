import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';

class MainNavigationLayout extends StatelessWidget {
  const MainNavigationLayout({
    required this.child,
    required this.location,
    super.key,
  });

  final Widget child;
  final String location;

  static const _destinations = [
    ('/home', Icons.home_rounded, 'Home'),
    ('/explore', Icons.map_rounded, 'Explore'),
    ('/favorites', Icons.favorite_rounded, 'Favorites'),
    ('/bookings', Icons.book_online_rounded, 'Bookings'),
    ('/profile', Icons.person_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _destinations.indexWhere(
      (item) => location.startsWith(item.$1),
    );
    final selectedIndex = currentIndex < 0 ? 0 : currentIndex;

    return Scaffold(
      extendBody: true,
      body: child,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/planner'),
        backgroundColor: AppColors.mediterraneanBlue,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.auto_awesome_rounded),
        label: const Text('Plan trip'),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(0.18)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.22),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: List.generate(_destinations.length, (index) {
                  final item = _destinations[index];
                  final selected = index == selectedIndex;

                  return Expanded(
                    child: _BottomNavItem(
                      icon: item.$2,
                      label: item.$3,
                      selected: selected,
                      onTap: () => context.go(item.$1),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: selected
              ? const LinearGradient(
                  colors: [Color(0xFF1A8B9D), Color(0xFF006B7D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.16),
                    Colors.white.withOpacity(0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          border: Border.all(
            color: selected
                ? Colors.white.withOpacity(0.3)
                : Colors.white.withOpacity(0.16),
          ),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? const Color(0xFF006B7D).withOpacity(0.32)
                  : Colors.black.withOpacity(0.14),
              blurRadius: selected ? 18 : 12,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(selected ? 0.08 : 0.04),
              blurRadius: 8,
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withOpacity(selected ? 1 : 0.9),
                fontSize: 11.5,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
