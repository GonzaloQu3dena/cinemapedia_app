import 'package:cinemapedia_app/features/cinema/application/providers/providers.dart';
import 'package:cinemapedia_app/features/cinema/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            Container(
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
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                final movieRepository = ref.read(movieRepositoryProvider);

                showSearch(
                  context: context,
                  delegate: SearchMovieDelegate(
                    searchMovieCallback: (query) =>
                        movieRepository.searchMovies(query),
                  ),
                );
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
