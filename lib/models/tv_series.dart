import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/models/genre.dart';

class TVSeries {
  final String? backdropPath;
  final String? firstAirDate;
  final List<Genre>? genres;
  final int? id;
  final bool? inProduction;
  final String? lastAirDate;
  final String? name; //title
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? status;
  final double? voteAverage;
  final int? voteCount;

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
    this.popularity,
    this.posterPath,
    this.status,
    this.voteAverage,
    this.voteCount,
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
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'],
      status: json['status'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'],
    );
  }
}

