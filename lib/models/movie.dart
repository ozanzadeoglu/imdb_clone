import 'package:imdb_app/constants/hive_adapters.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/models/genre.dart';
import 'package:hive/hive.dart';

part 'movie.g.dart';

//for movie details
@HiveType(typeId: HiveAdapters.movie)
class Movie {
   @HiveField(0)
  final String? backdropPath;

  @HiveField(1)
  final int? budget;

  @HiveField(2)
  final List<Genre>? genres;

  @HiveField(3)
  final int? id;

  @HiveField(4)
  final String? originalLanguage;

  @HiveField(5)
  final String? originalTitle;

  @HiveField(6)
  final String? overview;

  @HiveField(7)
  final double popularity;

  @HiveField(8)
  final String? posterPath;

  @HiveField(9)
  final String? releaseDate;

  @HiveField(10)
  final String? status;

  @HiveField(11)
  final String? title;

  @HiveField(12)
  final double voteAverage;

  @HiveField(13)
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

