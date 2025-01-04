import 'package:animate_do/animate_do.dart';
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
            return _MovieItem(movie: movies[index]);
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
