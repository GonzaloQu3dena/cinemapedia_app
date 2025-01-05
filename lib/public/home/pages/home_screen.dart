import 'package:cinemapedia_app/public/home/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia_app/public/home/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  final Widget childView;

  const HomeScreen({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(),
          Expanded(
            child: childView,
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}
