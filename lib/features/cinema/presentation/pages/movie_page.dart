import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  static const name = "movie-page";

  final String movideId;

  const MoviePage({
    super.key,
    required this.movideId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieId: $movideId'),
      ),
    );
  }
}
