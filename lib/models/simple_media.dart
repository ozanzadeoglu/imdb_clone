import 'package:imdb_app/constants/string_constants.dart';

class SimpleMedia {
  final String? backdropPath;
  final String? title;
  final String? name;
  final int? id;
  final String? overview;
  final String? posterPath;
  final double? voteAverage;
  final String? mediaType;

  SimpleMedia({
    this.backdropPath,
    this.title,
    this.name,
    this.id,
    this.overview,
    this.posterPath,
    this.voteAverage,
    this.mediaType
  });

  // Factory constructor to create a SimpleMedia object from a JSON map
  factory SimpleMedia.fromJson(Map<String, dynamic> json) {
    return SimpleMedia(
      backdropPath: json['backdrop_path'],
      title: json['title'],
      name: json['name'],
      id: json['id'],
      overview: json['overview'] == "" || json['overview'] == null ? StringConstants.noOverview : json['overview'],
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      mediaType: json['media_type'],
    );
  }
}
