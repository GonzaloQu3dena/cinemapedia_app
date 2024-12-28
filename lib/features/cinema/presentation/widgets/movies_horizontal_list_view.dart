import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia_app/core/helpers/human_formats.dart';
import 'package:cinemapedia_app/features/cinema/domain/entities/movie.dart';

/// ### Movie Horizontal Listview
/// It's a horizontal listview that shows a list of movies. It has a title and a subtitle.
///
/// #### Properties:
/// - [movies]: List of movies to show.
/// - [title]: Title of the listview.
/// - [subTitle]: Subtitle of the listview.
/// - [loadNextPage]: Callback to load the next page of movies.
///
/// #### Author:
/// Gonzalo Quedena
class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

/// ### Movie Horizontal Listview State
/// It's the state of the [MovieHorizontalListview] widget. It has a scroll controller to listen the scroll events.
///
/// #### Properties:
/// - [scrollController]: Scroll controller to listen the scroll events.
///
/// #### Methods:
/// - [initState]: Initialize the state. It adds a listener to the scroll controller.
/// - [dispose]: Dispose the state. It disposes the scroll controller.
///
/// #### Author:
/// Gonzalo Quedena
class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(
      () {
        /// If the loadNextPage is null, return.
        if (widget.loadNextPage == null) return;

        /// Load the next page of movies when the user reaches the end of the list.
        if ((scrollController.position.pixels + 200) >=
            scrollController.position.maxScrollExtent) {
          widget.loadNextPage!();
        }
      },
    );
  }

  ///### Dispose
  ///Dispose the state. It disposes the scroll controller.
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
          
            _Title(
              title: widget.title,
              subTitle: widget.subTitle,
            ),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(
                  child: _Slide(movie: widget.movies[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

/// ### Slide
/// It's a slide that shows a movie. It has the movie poster, title, rating and popularity. It's used in the [MovieHorizontalListview].
///
/// #### Properties:
/// - [movie]: Movie to show.
///
/// #### Author:
/// Gonzalo Quedena
class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    /// Return the slide. It has the movie poster, title, rating and popularity.
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            //* Image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          const SizedBox(height: 5),

          //* Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title.value,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),

          //* Rating
          SizedBox(
            width: 150,

            child: Row(
              children: [
                Icon(
                  Icons.star_half_outlined,
                  color: Colors.yellow.shade800,
                ),
                
                const SizedBox(width: 3),

                Text(
                  '${movie.voteAverage}',
                  style: textStyles.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800),
                ),

                const Spacer(),

                Text(
                  HumanFormats.number(movie.popularity.value),
                  style: textStyles.bodySmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// ### Title
/// It's a title that shows a title and a subtitle. It's used in the [MovieHorizontalListview].
///
/// #### Properties:
/// - [title]: Title of the listview.
/// - [subTitle]: Subtitle of the listview.
///
/// #### Author:
/// Gonzalo Quedena
class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),

      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),

          const Spacer(),

          if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(
                visualDensity: VisualDensity.compact,
              ),
              onPressed: () {},
              child: Text(subTitle!),
            )
        ],
      ),
    );
  }
}
