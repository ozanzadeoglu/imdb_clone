class PosterCardMedia {
  final String? title;
  final int? id;
  final String? posterPath;
  final double? voteAverage;
  final String? mediaType;

  PosterCardMedia({
    this.title,
    this.id,
    this.posterPath,
    this.voteAverage,
    this.mediaType
  });

    factory PosterCardMedia.fromJson(Map<String, dynamic> json) {
    return PosterCardMedia(
      title: json['name'] ?? json['title'],
      id: json['id'] as int?,
      posterPath: json['poster_path'] ?? json["profile_path"],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      mediaType: json['media_type'],
    );
  }
      factory PosterCardMedia.fromJsonWithType(Map<String, dynamic> json, String mediaType) {
    return PosterCardMedia(
      title: json['name'] ?? json['title'],
      id: json['id'] as int?,
      posterPath: json['poster_path'] ?? json["profile_path"],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      mediaType: mediaType,
    );
  }
}