import 'package:imdb_app/constants/string_constants.dart';

class SimpleTvSeriesEpisode {
  final String? airDate;
  final int? episodeID;
  final String episodeName;
  final String episodeOverview;
  final double? episodeVoteAverage;
  final int? episodeRuntime;
  final String? episodeImagePath;

  SimpleTvSeriesEpisode({
    required this.airDate,
    required this.episodeID,
    required this.episodeName,
    required this.episodeOverview,
    required this.episodeVoteAverage,
    required this.episodeRuntime,
    required this.episodeImagePath,
  });

  factory SimpleTvSeriesEpisode.fromJson(Map<String, dynamic> json) {
    return SimpleTvSeriesEpisode(
      airDate: json['air_date'] as String?,
      episodeID: json['id'] as int?,
      episodeName: json['name'] == "" || json['name'] == null ? StringConstants.tvSeriesNoEpisodeName : json['name'],
      episodeOverview: json['overview'] == "" || json['overview'] == null ? StringConstants.noOverview : json['overview'],
      episodeVoteAverage: (json['vote_average'] as num?)?.toDouble(),
      episodeRuntime: json['runtime'] as int?,
      episodeImagePath: json['still_path'] as String?,
    );
  }
}
