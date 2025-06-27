import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imdb_app/constants/box_names.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';
import 'package:imdb_app/models/bookmark/bookmarked_movie.dart';
import 'package:imdb_app/models/movie.dart';
import 'package:imdb_app/services/bookmark/bookmark_service.dart';

class BookmarkViewController with ChangeNotifier {
  late final BookmarkService bookmarkService;
  late final Box<BookmarkEntity> bookmarkBox;

  BookmarkViewController() {
    bookmarkService = BookmarkService();
    bookmarkBox = bookmarkService.box;
  }
  //Box<BookmarkEntity>? get box => bookmarkService.box;
  final testBookmarkedMovie = BookmarkedMovie(
      bookmarkedDate: DateTime.now(),
      movie: Movie(
          popularity: 1,
          voteAverage: 1,
          voteCount: 1,
          id: 221,
          posterPath:
              "https://image.tmdb.org/t/p/w500/h7shL668vhC2wsZQSBWzxkMuZ8K.jpg",
          title: "Test Movie"));

  void removeBookmark(BookmarkEntity item) {
    bookmarkService.removeItem(item.id);
  }

  void addTestBookmark() {
    bookmarkService.putItem(testBookmarkedMovie.id, testBookmarkedMovie);
  }

  void removeTestBookmark() {
    bookmarkService.removeItem(testBookmarkedMovie.id);
  }

  List<BookmarkEntity>? fetchBookmarks() {
    return bookmarkService.fetchValues();
  }

  void clearBookmarks() {
    bookmarkService.clearBox();
  }
}
