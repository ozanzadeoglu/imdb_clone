import 'package:hive/hive.dart';
import 'package:imdb_app/constants/hive_adapters.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';
import 'package:imdb_app/models/people.dart';

part 'bookmarked_people.g.dart';

@HiveType(typeId: HiveAdapters.bookmarkedPeople)
class BookmarkedPeople extends BookmarkEntity {
  @HiveField(3)
  final People person;

  BookmarkedPeople({
    required super.bookmarkedDate,
    required this.person,
  }) : super(
          id: "${MediaTypes.person.value}_${person.id}",
          mediaType: MediaTypes.person,
          note: null
        );

  @override
  String get title => person.name ?? "";
}
