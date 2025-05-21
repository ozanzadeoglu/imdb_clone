import 'package:hive/hive.dart';
import 'package:imdb_app/constants/hive_adapters.dart';

part 'genre.g.dart';

@HiveType(typeId: HiveAdapters.genre)
class Genre {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}
