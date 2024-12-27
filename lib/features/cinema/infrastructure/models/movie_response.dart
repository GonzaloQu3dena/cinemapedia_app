import 'package:cinemapedia_app/features/cinema/infrastructure/models/movie_model.dart';

/// ### Movie Response
/// It is a class that represents the response of the movie list.
/// 
/// #### Properties:
/// - [dates]: It is a [Dates] object that represents the dates of the response.
/// - [page]: It is an integer that represents the page of the response.
/// - [results]: It is a list of [MovieModel] objects that represents the movies of the response.
/// - [totalPages]: It is an integer that represents the total pages of the response.
/// - [totalResults]: It is an integer that represents the total results of the response.
/// 
/// #### Methods:
/// - [toJson]: It converts a [MovieResponse] object to a json.
/// - [fromJson]: It creates a [MovieResponse] object from a json.
/// 
/// #### Author: 
/// Gonzalo Quedena
class MovieResponse {
  final Dates? dates;
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MovieResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  /// It creates a [MovieResponse] object from a json.
  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieModel>.from(
          json["results"].map((x) => MovieModel.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  /// It converts a [MovieResponse] object to a json.
  Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": List<dynamic>.from(
          results.map((x) => x.toJson()),
        ),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

/// ### Dates
/// It is a class that represents the dates of the response.
/// 
/// #### Properties:
/// - [maximum]: It is a [DateTime] object that represents the maximum date of the response.
/// - [minimum]: It is a [DateTime] object that represents the minimum date of the response.
/// 
/// #### Methods:
/// - [toJson]: It converts a [Dates] object to a json.
/// - [fromJson]: It creates a [Dates] object from a json.
/// 
/// #### Author:
/// Gonzalo Quedena
class Dates {
  final DateTime maximum;
  final DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  /// It creates a [Dates] object from a json.
  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  /// It converts a [Dates] object to a json.
  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
