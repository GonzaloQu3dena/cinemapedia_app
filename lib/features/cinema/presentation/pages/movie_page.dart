import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/application/providers/actors_provider.dart';
import 'package:cinemapedia_app/features/cinema/application/providers/is_favorite_provider.dart';
import 'package:cinemapedia_app/features/cinema/presentation/controllers/cinema_controller.dart';

/// ### Movie Page
/// This page displays detailed information about a specific movie.
///
/// #### Properties:
/// - [movieId]: The ID of the movie to display.
///
/// #### Author:
/// Gonzalo Quedena
class MoviePage extends ConsumerStatefulWidget {
  static const name = "movie-page";

  final String movieId;

  const MoviePage({
    super.key,
    required this.movieId,
  });

  @override
  MoviePageState createState() => MoviePageState();
}

/// ### Movie Page State
/// This is the state of the Movie Page, it loads the movie and its actors when the view is initialized.
///
/// #### Author:
/// Gonzalo Quedena
class MoviePageState extends ConsumerState<MoviePage> {
  @override
  void initState() {
    super.initState();
    _loadMovie();
  }

  /// Loads the movie and its actors by ID.
  void _loadMovie() {
    final movieId = int.tryParse(widget.movieId) ?? 0;
    ref
        .read(cinemaControllerProvider.notifier)
        .loadMovieById(movieId.toString());
    ref.read(cinemaControllerProvider.notifier).loadActorsByMovie(movieId);
  }

  @override
  Widget build(BuildContext context) {
    final selectedMovie = ref.watch(cinemaControllerProvider).selectedMovie;

    if (selectedMovie == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: selectedMovie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetail(movie: selectedMovie),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}

/// ### Movie Detail
/// This widget displays detailed information about the movie.
///
/// #### Properties:
/// - [movie]: The movie to display.
///
/// #### Author:
/// Gonzalo Quedena
class _MovieDetail extends StatelessWidget {
  final Movie movie;

  const _MovieDetail({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyle.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: movie.genreIds.map((genre) {
              return Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(genre.toString()),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        _ActorsByMovie(movieId: movie.id.toString()),
        const SizedBox(height: 50),
      ],
    );
  }
}

/// ### Custom Sliver App Bar
/// This widget displays a custom sliver app bar with the movie's poster and title.
///
/// #### Properties:
/// - [movie]: The movie to display.
///
/// #### Author:
/// Gonzalo Quedena
class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.6,
      foregroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 0.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 0.0),
          child: IconButton(  
            onPressed: () {
              ref
                  .read(cinemaControllerProvider.notifier)
                  .toggleFavoriteMovie(movie);
            },
            icon: isFavoriteFuture.when(
              loading: () => const CircularProgressIndicator(
                strokeWidth: 2,
              ),
              data: (isFavorite) => isFavorite
                  ? const Icon(Icons.favorite_rounded, color: Colors.red)
                  : const Icon(Icons.favorite_border),
              error: (_, __) => throw UnimplementedError(),
            ),
            //const Icon(Icons.favorite_border),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [0.0, 0.4],
              colors: const [Colors.black54, Colors.transparent],
            ),
            _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.7, 1.0],
              colors: const [Colors.transparent, Colors.black87],
            ),
            _CustomGradient(
              begin: Alignment.topLeft,
              stops: const [0.0, 0.4],
              colors: const [Colors.black87, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

/// ### Custom Gradient
/// This widget displays a custom gradient.
///
/// #### Properties:
/// - [begin]: The alignment of the gradient's start.
/// - [end]: The alignment of the gradient's end.
/// - [stops]: The stops of the gradient.
/// - [colors]: The colors of the gradient.
///
/// #### Author:
/// Gonzalo Quedena
class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    this.begin = Alignment.center,
    this.end = Alignment.centerRight,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}

/// ### Actors By Movie
/// This widget displays a list of actors for the given movie.
///
/// #### Properties:
/// - [movieId]: The ID of the movie to fetch actors for.
///
/// #### Author:
/// Gonzalo Quedena
class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Actor Photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Actor Name
                const SizedBox(height: 5),

                Text(
                  actor.name,
                  maxLines: 2,
                ),

                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
