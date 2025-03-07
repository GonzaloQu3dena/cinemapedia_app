import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/presentation/widgets/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// ### Movies Mansory
/// This widget will show the movies in a mansory layout.
/// 
/// #### Properties:
/// - [movies]: List of movies to show.
/// - [loadNextpage]: Callback to load the next page.
/// 
/// #### Author:
/// Gonzalo Quedena
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
/// ### Movies Mansory State
/// This is the state of the [MoviesMansory] widget.
/// 
/// #### Properties:
/// - [scrollController]: Scroll controller to listen the scroll events.
/// 
/// #### Methods:
/// - [initState]: Initialize the state.
/// - [dispose]: Dispose the state.
/// 
/// #### Author:
/// Gonzalo Quedena
class _MoviesMansoryState extends State<MoviesMansory> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextpage == null) return;

      if ((scrollController.position.pixels + 100) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextpage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: MasonryGridView.count(
        controller: scrollController,
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
