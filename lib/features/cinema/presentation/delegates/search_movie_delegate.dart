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
            final movie = movies[index];

            return ListTile( 
              title: Text(movie.title.value),
            );
          },
        );
      },
    );
  }
}
