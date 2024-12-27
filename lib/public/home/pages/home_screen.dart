import 'package:cinemapedia_app/features/cinema/presentation/pages/cinema_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CinemaPage(),
    );
  }
}
