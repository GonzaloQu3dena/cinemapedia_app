import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/presentation/controllers/cinema_controller.dart';
import '../widgets/movie_list.dart';

/// ### Cinema Page
/// This page is the main page of the app, it shows the list of movies that are currently playing in theaters.
/// 
/// #### Properties:
/// - [name]: The name of the page.
/// 
/// 
class CinemaPage extends StatelessWidget {
  static const name = 'home-screen';

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
    ref.read(cinemaControllerProvider.notifier).loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(cinemaControllerProvider);

    print('Building CinemaView with ${nowPlayingMovies.length} movies');

    if (nowPlayingMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return MovieList(movies: nowPlayingMovies);
  }
}