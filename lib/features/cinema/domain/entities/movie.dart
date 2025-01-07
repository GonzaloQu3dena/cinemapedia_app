import 'package:isar/isar.dart';
import 'package:cinemapedia_app/features/cinema/domain/valueobjects/value_objects.dart';

part 'movie.g.dart';

/// #### Movie
/// Entity class that represents a movie.
///
/// #### Properties:
/// - isAdult: Is a boolean value that indicates if the movie is for adults.
/// - backdropPath: Is a string that represents the path of the backdrop image.
/// - genreIds: Is a list of integers that represents the genre IDs of the movie.
/// - id: Is an integer that represents the ID of the movie.
/// - originalLanguage: Is a string that represents the original language of the movie.
/// - originalTitle: Is a string that represents the original title of the movie.
/// - overview: Is a string that represents the overview of the movie.
/// - popularity: Is a double that represents the popularity of the movie.
/// - posterPath: Is a string that represents the path of the poster image.
/// - releaseDate: Is a DateTime that represents the release date of the movie.
/// - title: Is a string that represents the title of the movie.
/// - hasVideo: Is a boolean value that indicates if the movie has a video.
/// - voteAverage: Is a double that represents the average vote of the movie.
/// - voteCount: Is an integer that represents the vote count of the movie.
///
/// #### Constraints:
/// - The [id] of the movie must be greater than 0.
/// - The [originalLanguage] of the movie cannot be empty.
///
/// #### Author:
/// Gonzalo Quedena
@collection
class Movie {
  Id? idIsar;

  final bool isAdult;
  final String backdropPath;

  final List<int> genreIds;

  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool hasVideo;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.isAdult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.hasVideo,
    required this.voteAverage,
    required this.voteCount,
  })  : assert(id > 0, 'Movie ID must be greater than 0'),
        assert(
            originalLanguage.isNotEmpty, 'Original language cannot be empty');

  @ignore
  Title get originalTitleValue => Title(originalTitle);
  @ignore
  Overview get overviewValue => Overview(overview);
  @ignore
  Popularity get popularityValue => Popularity(popularity);
  @ignore
  ReleaseDate get releaseDateValue => ReleaseDate(releaseDate);
  @ignore
  Title get titleValue => Title(title);
  @ignore
  VoteAverage get voteAverageValue => VoteAverage(voteAverage);

  @ignore
  List<GenderId> get genreIdsAsGenderId => genreIds
      .map((id) => GenderId(
            id.toString(),
          ))
      .toList();
}
