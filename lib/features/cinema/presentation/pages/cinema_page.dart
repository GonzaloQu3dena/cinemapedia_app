import 'package:cinemapedia_app/public/home/widgets/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/features/cinema/presentation/widgets/movies_horizontal_list_view.dart';
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
    _loadAllMovies();
  }

  void _loadAllMovies() {
    final notifier = ref.read(cinemaControllerProvider.notifier);
    notifier.loadMovies();
    notifier.loadSlideMovies();
    notifier.loadUpcomingMovies();
    notifier.loadPopularMovies();
  }

  bool _areMoviesLoaded(CinemaState cinemaState) {
    return cinemaState.slideShowMovies.isNotEmpty &&
        cinemaState.nowPlayingMovies.isNotEmpty &&
        cinemaState.upcomingMovies.isNotEmpty &&
        cinemaState.popularMovies.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final cinemaState = ref.watch(cinemaControllerProvider);

    print(
        'Building CinemaView with ${cinemaState.slideShowMovies.length} movies');

    if (!_areMoviesLoaded(cinemaState)) {
      return const FullScreenLoader();
    }

    /// Custom Scroll View with Slivers to show the Slide Show and the Horizontal List View of Movies.
    return CustomScrollView(
      slivers: [
        //* Slide Show
        SliverToBoxAdapter(
          child: MoviesSlideShow(movies: cinemaState.slideShowMovies),
        ),

        //* In theaters
        SliverToBoxAdapter(
          child: MovieHorizontalListView(
            movies: cinemaState.nowPlayingMovies,
            title: 'In theaters',
            subTitle: 'Monday 20th',
            loadNextPage: () => ref
                .read(cinemaControllerProvider.notifier)
                .loadNextPageNowPlayingMovies(),
          ),
        ),

        //* Coming soon
        SliverToBoxAdapter(
          child: MovieHorizontalListView(
            movies: cinemaState.upcomingMovies,
            title: 'Coming soon',
            subTitle: 'In this month',
            loadNextPage: () => ref
                .read(cinemaControllerProvider.notifier)
                .loadNextPageUpcomingMovies(),
          ),
        ),

        //* Popular
        SliverToBoxAdapter(
          child: MovieHorizontalListView(
            movies: cinemaState.popularMovies,
            title: 'Popular',
            subTitle: 'In this month',
            loadNextPage: () => ref
                .read(cinemaControllerProvider.notifier)
                .loadNextPagePopularMovies(),
          ),
        )
      ],
    );
  }
}
