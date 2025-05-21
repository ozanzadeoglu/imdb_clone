import 'package:hive/hive.dart';
import 'package:imdb_app/constants/hive_adapters.dart';

part 'media_types.g.dart';

@HiveType(typeId: HiveAdapters.mediaTypes)
enum MediaTypes {
  @HiveField(0)
  movie("movie"),
  @HiveField(1)
  tv("tv"),
  @HiveField(2)
  person("person");

  final String value;
  const MediaTypes(this.value);
}


