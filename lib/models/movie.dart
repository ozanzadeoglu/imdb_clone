import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/models/genre.dart';
//for movie details
class Movie {
  final String? backdropPath;
  final int? budget;
  final List<Genre>? genres;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? status;
  final String? title;
  final double voteAverage;
  final int voteCount;

  Movie({
    this.backdropPath,
    this.budget,
    this.genres,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    this.status,
    this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  // Factory constructor to create a Movie object from a JSON map
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      backdropPath: json['backdrop_path'],
      budget: json['budget'],
      genres: (json['genres'] as List?)
          ?.map((genre) => Genre.fromJson(genre))
          .toList(),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      //return StringConstants.noOverview if there's no overview.
      overview: json['overview'] == "" || json['overview'] == null ? StringConstants.noOverview : json['overview'],
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      status: json['status'],
      title: json['title'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
    );
  }
}


