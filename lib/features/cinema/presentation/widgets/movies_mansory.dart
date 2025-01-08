import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/presentation/widgets/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MoviesMansory extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextpage;

  const MoviesMansory({
    super.key,
    required this.movies,
    this.loadNextpage,
  });

  @override
  State<MoviesMansory> createState() => _MoviesMansoryState();
}

class _MoviesMansoryState extends State<MoviesMansory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: MasonryGridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                MoviePosterLink(movie: widget.movies[index])
              ],
            );
          }

          return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}
