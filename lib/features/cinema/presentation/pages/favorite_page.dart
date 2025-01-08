import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/presentation/widgets/movies_mansory.dart';
import 'package:cinemapedia_app/features/cinema/application/providers/favorite_movies_provider.dart';

/// ### Favorite Page
/// This page shows the list of favorite movies.
///
/// #### Author:
/// Gonzalo Quedena
class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  FavoritePageState createState() => FavoritePageState();
}

/// ### Favorite Page State
/// This is the state of the Favorite Page, it shows the list of favorite movies.
///
/// #### Properties:
/// - [isLoading]: It indicates if the page is loading.
/// - [isLastPage]: It indicates if the page is the last page.
///
/// #### Methods:
/// - [initState]: It loads the next page of movies when the view is initialized.
/// - [loadNextPage]: It loads the next page of movies.
///
/// #### Author:
/// Gonzalo Quedena
class FavoritePageState extends ConsumerState<FavoritePage> {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  /// It loads the next page of movies when the view is initialized.
  void initState() {
    super.initState();

    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  /// It loads the next page of movies.
  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;

      return FadeInUp(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_outline_sharp,
                  size: 60,
                  color: colors.primary,
                ),
                Text(
                  'Oh no!',
                  style: TextStyle(fontSize: 30, color: colors.primary),
                ),
                const Text(
                  'You don\'t have any favorite movies yet.',
                  style: TextStyle(fontSize: 20, color: Colors.black45),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                FilledButton.tonal(
                  onPressed: () => context.go('/'),
                  child: const Text('Discover movies'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: MoviesMansory(
        movies: favoriteMovies,
        loadNextpage: loadNextPage,
      ),
    );
  }
}
