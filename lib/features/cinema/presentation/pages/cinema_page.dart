import 'package:cinemapedia_app/features/cinema/presentation/widgets/movies_horizontal_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/features/cinema/application/providers/movies_provider.dart';
import 'package:cinemapedia_app/features/cinema/presentation/widgets/movies_slide_show.dart';
import 'package:cinemapedia_app/features/cinema/presentation/controllers/cinema_controller.dart';

/// ### Cinema Page
/// This page is the main page of the app, it shows the list of movies that are currently playing in theaters.
///
/// #### Properties:
/// - [name]: The name of the page.
///
/// #### Author:
/// Gonzalo Quedena
class CinemaPage extends StatelessWidget {
  static const name = 'cinema-page';

  const CinemaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _CinemaView());
  }
}

/// ### Cinema View
/// This is the main view of the Cinema Page, it shows the list of movies that are currently playing in theaters.
///
/// #### Author:
/// Gonzalo Quedena
class _CinemaView extends ConsumerStatefulWidget {
  const _CinemaView();

  @override
  _CinemaViewState createState() => _CinemaViewState();
}

/// ### Cinema View State
/// This is the state of the Cinema View, it shows the list of movies that are currently playing in theaters.
///
/// #### Properties:
/// - [initState]: It loads the movies when the view is initialized.
///
/// #### Author:
/// Gonzalo Quedena
class _CinemaViewState extends ConsumerState<_CinemaView> {
  @override
  void initState() {
    super.initState();

    /// Load the movies when the view is initialized.
    ref.read(cinemaControllerProvider.notifier).loadMovies();
    ref.read(cinemaControllerProvider.notifier).loadSlideMovies();
    ref.read(cinemaControllerProvider.notifier).loadUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    final slideShowMovies = ref.watch(slideShowMoviesProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    print('Building CinemaView with ${slideShowMovies.length} movies');

    if (slideShowMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    /// Custom Scroll View with Slivers to show the Slide Show and the Horizontal List View of Movies.
    return CustomScrollView(
      slivers: [
        //* Slide Show
        SliverToBoxAdapter(
          child: MoviesSlideShow(movies: slideShowMovies),
        ),

        //* In theaters
        SliverToBoxAdapter(
          child: MovieHorizontalListView(
            movies: nowPlayingMovies,
            title: 'In theaters',
            subTitle: 'Monday 20th',
            loadNextPage: () =>
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
          ),
        ),

        //* Commig soon
        SliverToBoxAdapter(
          child: MovieHorizontalListView(
            movies: upcomingMovies,
            title: 'Coming soon',
            subTitle: 'In this month',
            loadNextPage: () =>
                ref.read(upcomingMoviesProvider.notifier).getUpcomingMovies(),
          ),
        )
      ],
    );
  }
}
