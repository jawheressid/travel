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

    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/planner'),
        backgroundColor: AppColors.mediterraneanBlue,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.auto_awesome_rounded),
        label: const Text('Plan trip'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex < 0 ? 0 : currentIndex,
        destinations: _destinations
            .map(
              (item) =>
                  NavigationDestination(icon: Icon(item.$2), label: item.$3),
            )
            .toList(),
        onDestinationSelected: (index) => context.go(_destinations[index].$1),
      ),
    );
  }
}
