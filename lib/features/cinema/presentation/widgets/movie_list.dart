import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:flutter/material.dart';

/// ### Movie List
/// It is a widget that shows a list of movies.
/// 
/// #### Properties:
/// - [movies]: It is a list of [Movie] objects that represents the movies to show.
/// 
/// #### Author:
/// Gonzalo Quedena
class MovieList extends StatelessWidget {
  
  final List<Movie> movies; 

  const MovieList({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          title: Text(movie.title),
        );
      },
    );
  }
}