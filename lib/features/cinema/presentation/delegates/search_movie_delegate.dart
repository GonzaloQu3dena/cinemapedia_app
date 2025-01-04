import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/core/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';

typedef SearchMovieCallback = Future<List<Movie>> Function(String query);

/// ### Search Movie Delegate
/// It is a delegate that will be used to search movies.
///
/// #### Properties:
/// - [searchFieldLabel]: It is the label of the search field.
///
/// #### Methods:
/// - [buildActions]: It builds the actions of the search bar.
/// - [buildLeading]: It builds the leading of the search bar.
/// - [buildResults]: It builds the results of the search bar.
/// - [buildSuggestions]: It builds the suggestions of the search bar.
///
/// #### Author:
/// Gonzalo Quedena
class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMovieCallback searchMovieCallback;

  SearchMovieDelegate({
    required this.searchMovieCallback,
  });

  @override
  String get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //if (query.isNotEmpty)
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovieCallback(query),

      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,

          itemBuilder: (context, index) {
            return _MovieItem(
              movie: movies[index],
              onMovieSelected: close,
            );
          },
        );
      },
    );
  }
}

/// ### Movie Item
/// It is a widget that will be used to show a movie item.
/// 
/// #### Properties:
/// - [movie]: It is the movie to show.
/// - [onMovieSelected]: It is the function to call when the movie is selected.
/// 
/// #### Author:
/// Gonzalo Quedena
class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(
                    child: child,
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 10,
            ),
            
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title.value,
                    style: textTheme.titleMedium,
                  ),
                  (movie.overview.value.length > 100)
                      ? Text('${movie.overview.value.substring(0, 100)}...')
                      : Text(movie.overview.value),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        HumanFormats.number(movie.voteAverage.value, 1),
                        style: textTheme.bodyMedium!.copyWith(
                          color: Colors.yellow.shade900,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
