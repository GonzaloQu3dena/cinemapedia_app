import 'package:flutter/material.dart';
import 'package:cinemapedia_app/public/home/widgets/custom_appbar.dart';
import 'package:cinemapedia_app/features/cinema/presentation/pages/cinema_page.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(),
          
          Expanded(
            child: const CinemaPage(),
          )
        ],
      ),
    );
  }
}
