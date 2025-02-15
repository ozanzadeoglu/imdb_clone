import 'package:hive/hive.dart';

part 'simple_list_tile_media.g.dart';

@HiveType(typeId: 1)
class SimpleListTileMedia {
  @HiveField(0)
  final int id;
  //profile-path
  @HiveField(1)
  final String? posterPath;
  //title
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String mediaType;
  //only for actors
  @HiveField(4)
  String? knownForDepartment;
  //movie and tv, no end date in api
  @HiveField(5)
  String? releaseDate;
  //for actors
  @HiveField(6)
  String? mostKnownMedia;

  //late DateTime storeDate;

  SimpleListTileMedia({
    this.knownForDepartment,
    this.releaseDate,
    this.mostKnownMedia,
    required this.id,
    required this.posterPath,
    required this.name,
    required this.mediaType,
  });

  factory SimpleListTileMedia.fromJson(Map<String, dynamic> json) {

    final knownForMap = (json['known_for'] as List?)?.firstOrNull as Map?;
    return SimpleListTileMedia(
      mostKnownMedia: knownForMap?['title'] ?? knownForMap?['name'],
      releaseDate: json['release_date'] ??
          json['first_air_date'],
      knownForDepartment: json['known_for_department'],
      name: json['name'] ?? json['title'],
      id: json['id'] as int,
      posterPath: json['poster_path'] ?? json['profile_path'],
      mediaType: json['media_type'],
    );
  }
}
