import 'package:flutter/material.dart';

/// ### Custom Bottom Navigation Bar
/// This is the custom bottom navigation bar widget that is used in the home screen to navigate between the home categories, and favorites screens.
/// 
/// #### Author: 
/// Gonzalo Quedena
class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      /// This is the bottom navigation bar elevation
      elevation: 0,

      /// These are the items in the bottom navigation bar
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categories'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites'
        ),
      ],
    );
  }
}
