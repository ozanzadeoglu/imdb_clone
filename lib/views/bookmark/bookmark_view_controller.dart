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

  late final ValueListenable<Box<BookmarkEntity>> _boxListenable; 
  late final VoidCallback _boxListener;

  List<BookmarkEntity> bookmarks = [];

  BookmarkViewController() {
    bookmarkService = BookmarkService();
    bookmarkBox = bookmarkService.box;
    fetchBookmarks();
    _boxListener = fetchBookmarks;
    _boxListenable = bookmarkBox.listenable();
    _boxListenable.addListener(_boxListener);

    // bookmarkBox.listenable().addListener(fetchBookmarks);
  }

  @override
  void dispose() {
    _boxListenable.removeListener(_boxListener);
    super.dispose();
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

  void fetchBookmarks() {
    bookmarks = bookmarkService.fetchValues() ?? [];
    bookmarks.sort((a, b) => b.bookmarkedDate.compareTo(a.bookmarkedDate));
    notifyListeners();
  }

  void clearBookmarks() {
    bookmarkService.clearBox();
  }
}
