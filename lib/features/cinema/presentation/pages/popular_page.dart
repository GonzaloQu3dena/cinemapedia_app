import 'package:cinemapedia_app/features/cinema/application/providers/providers.dart';
import 'package:cinemapedia_app/features/cinema/presentation/widgets/movies_mansory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularPage extends ConsumerStatefulWidget {
  const PopularPage({super.key});

  @override
  PopularPageState createState() => PopularPageState();
}

class PopularPageState extends ConsumerState<PopularPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final popularMovies = ref.watch(popularMoviesProvider);

    if (popularMovies.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }
    return Scaffold(
      body: MoviesMansory(
        movies: popularMovies,
        loadNextpage: () =>
            ref.read(popularMoviesProvider.notifier).loadNextPage(),
      ),
    );
  }
}
