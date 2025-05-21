import 'package:imdb_app/constants/hive_adapters.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/models/genre.dart';
import 'package:hive/hive.dart';

part 'tv_series.g.dart';

@HiveType(typeId: HiveAdapters.tvSeries)
class TVSeries {
  @HiveField(0)
  final String? backdropPath;

  @HiveField(1)
  final String? firstAirDate;

  @HiveField(2)
  final List<Genre>? genres;

  @HiveField(3)
  final int? id;

  @HiveField(4)
  final bool? inProduction;

  @HiveField(5)
  final String? lastAirDate;

  @HiveField(6)
  final String? name; //title

  @HiveField(7)
  final int? numberOfEpisodes;

  @HiveField(8)
  final int? numberOfSeasons;

  @HiveField(9)
  final String? overview;

  @HiveField(10)
  final double popularity;

  @HiveField(11)
  final String? posterPath;

  @HiveField(12)
  final String? status;

  @HiveField(13)
  final double voteAverage;

  @HiveField(14)
  final int voteCount;

  TVSeries({
    this.backdropPath,
    this.firstAirDate,
    this.genres,
    this.id,
    this.inProduction,
    this.lastAirDate,
    this.name,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.overview,
    required this.popularity,
    this.posterPath,
    this.status,
    required this.voteAverage,
    required this.voteCount,
  });

  // Factory constructor to create a TVSeries object from a JSON map
  factory TVSeries.fromJson(Map<String, dynamic> json) {
    return TVSeries(
      backdropPath: json['backdrop_path'],
      firstAirDate: json['first_air_date'],
      genres: (json['genres'] as List?)
          ?.map((genre) => Genre.fromJson(genre))
          .toList(),
      id: json['id'],
      inProduction: json['in_production'],
      lastAirDate: json['last_air_date'],
      name: json['name'],
      numberOfEpisodes: json['number_of_episodes'],
      numberOfSeasons: json['number_of_seasons'],
      overview: json['overview'] == "" || json['overview'] == null
          ? StringConstants.noOverview
          : json['overview'],
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'],
      status: json['status'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
    );
  }
}
