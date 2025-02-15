class SimplePosterCardMedia {
  final String? title;
  final int? id;
  final String? posterPath;
  final double? voteAverage;
  final String? mediaType;

  SimplePosterCardMedia({
    this.title,
    this.id,
    this.posterPath,
    this.voteAverage,
    this.mediaType
  });

    factory SimplePosterCardMedia.fromJson(Map<String, dynamic> json) {
    return SimplePosterCardMedia(
      title: json['name'] ?? json['title'],
      id: json['id'] as int?,
      posterPath: json['poster_path'] ?? json["profile_path"],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      mediaType: json['media_type'],
    );
  }
      factory SimplePosterCardMedia.fromJsonWithType(Map<String, dynamic> json, String mediaType) {
    return SimplePosterCardMedia(
      title: json['name'] ?? json['title'],
      id: json['id'] as int?,
      posterPath: json['poster_path'] ?? json["profile_path"],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      mediaType: mediaType,
    );
  }
}