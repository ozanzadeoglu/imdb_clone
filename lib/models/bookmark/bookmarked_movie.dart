import 'package:hive/hive.dart';
import 'package:imdb_app/constants/hive_adapters.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';
import 'package:imdb_app/models/movie.dart';

part 'bookmarked_movie.g.dart';

@HiveType(typeId: HiveAdapters.bookmarkedMovie)
class BookmarkedMovie extends BookmarkEntity {
  @HiveField(3)
  final Movie movie;

  BookmarkedMovie({
    required super.bookmarkedDate,
    required this.movie,
  }) : super(
          //Movie with id "123" converts to "movie_123"
          id: "${MediaTypes.movie.value}_${movie.id}",
          mediaType: MediaTypes.movie,
        );
}
