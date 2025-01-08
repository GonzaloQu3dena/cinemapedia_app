import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

/// ### Movie Poster Link
/// This widget will be used to show a movie poster and navigate to the movie details.
/// 
/// #### Properties:
/// - [movie]: The movie entity.
/// 
/// #### Author:
/// Gonzalo Quedena
class MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const MoviePosterLink({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.push('/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.posterPath),
        ),
      ),
    );
  }
}
