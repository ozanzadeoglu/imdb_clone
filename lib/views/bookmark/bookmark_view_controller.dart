import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';
import 'package:imdb_app/models/bookmark/bookmarked_movie.dart';
import 'package:imdb_app/models/movie.dart';
import 'package:imdb_app/services/bookmark/bookmark_service.dart';

enum DateSortOrder { descending, ascending }

class BookmarkViewController with ChangeNotifier {
  late final BookmarkService bookmarkService;
  late final Box<BookmarkEntity> bookmarkBox;

  late final ValueListenable<Box<BookmarkEntity>> _boxListenable;
  late final VoidCallback _boxListener;

  List<BookmarkEntity> _bookmarks = [];
  List<BookmarkEntity> filteredBookmarks = [];

  MediaTypes? typeFilter;
  DateSortOrder? dateFilter;

  BookmarkViewController() {
    bookmarkService = BookmarkService();
    bookmarkBox = bookmarkService.box;
    fetchBookmarks();
    _boxListener = fetchBookmarks;
    _boxListenable = bookmarkBox.listenable();
    _boxListenable.addListener(_boxListener);
  }

  @override
  void dispose() {
    _boxListenable.removeListener(_boxListener);
    super.dispose();
  }

  List<BookmarkEntity> get displayBookmarks {
    var list = List<BookmarkEntity>.from(_bookmarks);
    if (typeFilter != null) {
      list = list.where((b) => b.mediaType == typeFilter).toList();
    }

    if (dateFilter == DateSortOrder.ascending) {
      list.sort((a, b) => a.bookmarkedDate.compareTo(b.bookmarkedDate));
    } else {
      list.sort((a, b) => b.bookmarkedDate.compareTo(a.bookmarkedDate));
    }

    //list.sort((a, b) => b.bookmarkedDate.compareTo(a.bookmarkedDate));
    return list;
  }

  void addTypeFilter(MediaTypes type) {
    typeFilter = type;
    notifyListeners();
  }

  void clearTypeFilter() {
    typeFilter = null;
    notifyListeners();
  }

  void addDateFilter(DateSortOrder dateOrder){
    dateFilter = dateOrder;
    notifyListeners();
  }

    void clearDateFilter() {
    dateFilter = null;
    notifyListeners();
  }

  void removeBookmark(BookmarkEntity item) {
    bookmarkService.removeItem(item.id);
  }

  void fetchBookmarks() {
    _bookmarks = bookmarkService.fetchValues() ?? [];
    _bookmarks.sort((a, b) => b.bookmarkedDate.compareTo(a.bookmarkedDate));
    notifyListeners();
  }

  void clearBookmarks() {
    bookmarkService.clearBox();
  }
}
