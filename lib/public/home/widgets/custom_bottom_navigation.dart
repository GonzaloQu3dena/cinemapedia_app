import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// ### Custom Bottom Navigation Bar
/// This is the custom bottom navigation bar widget that is used in the home screen to navigate between the home categories, and favorites screens.
///
/// #### Author:
/// Gonzalo Quedena
class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    switch (location) {
      case '/':
        return 0;
      case '/popular':
        return 1;
      case '/favorites':
        return 2;

      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Go to the home screen
        context.go('/');
        break;
      case 1:
        // Go to the categories screen
        context.go('/popular');
        break;
      case 2:
        // Go to the favorites screen
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      /// This is the bottom navigation bar elevation
      elevation: 0,

      onTap: (index) => onItemTapped(context, index),

      currentIndex: getCurrentIndex(context),

      /// These are the items in the bottom navigation bar
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.thumbs_up_down_outlined),
          label: 'Popular',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites',
        ),
      ],
    );
  }
}
