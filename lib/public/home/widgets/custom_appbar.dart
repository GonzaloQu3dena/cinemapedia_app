import 'package:cinemapedia_app/features/cinema/application/providers/providers.dart';
import 'package:cinemapedia_app/features/cinema/application/providers/search_movies_provider.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';
import 'package:cinemapedia_app/features/cinema/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// ### Custom Appbar
/// It is a custom appbar that will be used in the home screen.
///
/// #### Author:
/// Gonzalo Quedena
class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Row(
          children: [
            _buildLogo(colors, titleStyle),
            const Spacer(),
            _buildSearchButton(context, ref),
          ],
        ),
      ),
    );
  }

  /// This method will build the logo.
  Widget _buildLogo(ColorScheme colors, TextStyle? titleStyle) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Icon(
            Icons.movie_outlined,
            color: colors.primary,
          ),
          
          const SizedBox(width: 5),

          Text(
            'Cinemapedia',
            style: titleStyle,
          ),
        ],
      ),
    );
  }

  /// This method will build the search button.
  Widget _buildSearchButton(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        final movieRepository = ref.read(movieRepositoryProvider);
        final searchQuery = ref.read(searchQueryProvider);

        showSearch<Movie?>(
          query: searchQuery,
          context: context,
          
          delegate: SearchMovieDelegate(
            searchMovieCallback: (query) {
              ref.read(searchQueryProvider.notifier).update((state) => query);
              return movieRepository.searchMovies(query);
            } 
          ),
        ).then(
          (movie) {
          
            if (movie != null && context.mounted) {
              context.push('/movie/${movie.id}');
            }
          },
        );
      },
      icon: const Icon(Icons.search),
    );
  }
}
