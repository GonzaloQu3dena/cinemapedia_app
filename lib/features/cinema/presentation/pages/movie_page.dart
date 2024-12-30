import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/presentation/controllers/cinema_controller.dart';

class MoviePage extends ConsumerStatefulWidget {
  static const name = "movie-page";

  final String movideId;

  const MoviePage({
    super.key,
    required this.movideId,
  });

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends ConsumerState<MoviePage> {
  @override
  void initState() {
    super.initState();
    _loadMovie();
  }

  void _loadMovie() {
    ref.read(cinemaControllerProvider.notifier).loadMovieById(int.tryParse(widget.movideId)!);
  }

  @override
  Widget build(BuildContext context) {
    final selectedMovie = ref.watch(cinemaControllerProvider).selectedMovie;

    return Scaffold(
      appBar: AppBar(
        title: Text('MovieId: ${widget.movideId}'),
      ),
      body: selectedMovie == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedMovie.title.value,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Overview:',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(selectedMovie.overview.value),
                  const SizedBox(height: 16),
                  Text(
                    'Release Date: ${selectedMovie.releaseDate}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rating: ${selectedMovie.voteAverage}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  // Agrega más detalles de la película aquí
                ],
              ),
            ),
    );
  }
}