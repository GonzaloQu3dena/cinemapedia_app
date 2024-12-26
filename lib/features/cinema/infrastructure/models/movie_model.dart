/// ### Movie Model
/// It is a model class that is used to parse the JSON data from the API.
/// 
/// #### Properties:
/// - [adult]: A boolean value that indicates whether the movie is for adults or not.
/// - [backdropPath]: A string that contains the path of the backdrop image.
/// - [genreIds]: A list of integers that contains the genre IDs of the movie.
/// - [id]: An integer that contains the ID of the movie.
/// - [originalLanguage]: A string that contains the original language of the movie.
/// - [originalTitle]: A string that contains the original title of the movie.
/// - [overview]: A string that contains the overview of the movie.
/// - [popularity]: A double value that contains the popularity of the movie.
/// - [posterPath]: A string that contains the path of the poster image.
/// - [releaseDate]: A DateTime object that contains the release date of the movie.
/// - [title]: A string that contains the title of the movie.
/// - [video]: A boolean value that indicates whether the movie has a video or not.
/// - [voteAverage]: A double value that contains the average vote of the movie.
/// - [voteCount]: An integer that contains the vote count of the movie.
/// 
/// #### Methods:
/// - [toJson]: It is a method that is used to convert the model object to a JSON object.
/// - [fromJson]: It is a factory method that is used to parse the JSON data from the API.
/// 
/// #### Author: 
/// Gonzalo Quedena
class MovieModel {
  final bool adult;
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
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieModel({
    required this.adult,
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
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  /// Factory method that is used to parse the JSON data from the API.
  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"] ?? '',
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] ?? '',
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  /// Method that is used to convert the model object to a JSON object.
  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
