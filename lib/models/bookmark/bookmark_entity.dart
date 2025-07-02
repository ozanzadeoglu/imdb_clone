import 'package:hive/hive.dart';
import 'package:imdb_app/enums/media_types.dart';


abstract class BookmarkEntity extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime bookmarkedDate;

  @HiveField(2)
  final MediaTypes mediaType;

  @HiveField(4)
  String? note;

  BookmarkEntity({
    required this.id,
    required this.bookmarkedDate,
    required this.mediaType,
    this.note
  });

  ///Extracts the integer ID of the underlying media from this bookmark’s composite ID.
  int? get originalMediaId {
    final parts = id.split('_');
    if (parts.length == 2) {
      return int.tryParse(parts[1]);
    }
    return null;
  }

  ///Convenience getter so every subclass can expose its own title.
  String get title;
}