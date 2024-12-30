import 'package:cinemapedia_app/features/cinema/presentation/pages/movie_page.dart';
import 'package:cinemapedia_app/public/home/pages/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: '/movie/:id',
          name: MoviePage.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';

            return MoviePage(
              movideId: movieId,
            );
          },
        )
      ],
    ),
  ],
);
