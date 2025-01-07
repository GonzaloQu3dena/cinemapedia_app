import 'package:cinemapedia_app/features/cinema/presentation/pages/cinema_page.dart';
import 'package:cinemapedia_app/features/cinema/presentation/pages/favorite_page.dart';
import 'package:cinemapedia_app/features/cinema/presentation/pages/movie_page.dart';
import 'package:cinemapedia_app/public/home/pages/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(
          childView: child,
        );
      },
      routes: [

        GoRoute(
          path: '/',
          builder: (context, state) {
            return const CinemaPage();
          },
          routes: [
            GoRoute(
              path: '/movie/:id',
              name: MoviePage.name,
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'no-id';

                return MoviePage(
                  movieId: movieId,
                );
              },
            ),
          ],
        ),

        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritePage();
          },
        ),
      ],
    ),

    /* GoRoute(
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
    ), */
  ],
);
