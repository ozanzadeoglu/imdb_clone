import 'package:hive/hive.dart';
import 'package:imdb_app/enums/media_types.dart';


abstract class BookmarkEntity extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime bookmarkedDate;

  @HiveField(2)
  final MediaTypes mediaType;

  BookmarkEntity({
    required this.id,
    required this.bookmarkedDate,
    required this.mediaType,
  });

  int? get originalMediaId {
    final parts = id.split('_');
    if (parts.length == 2) {
      return int.tryParse(parts[1]);
    }
    return null;
  }
}