import 'package:flutter/foundation.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';
import 'package:imdb_app/services/bookmark/bookmark_service.dart';

enum DateSortOrder { descending, ascending }

class BookmarkViewController with ChangeNotifier {
  final IBookmarkService _bookmarkService;
  List<BookmarkEntity> _bookmarks = [];

  MediaTypes? typeFilter;
  DateSortOrder? dateFilter;

  bool reload = false;

  BookmarkViewController({required bookmarkService})
      : _bookmarkService = bookmarkService,
        _bookmarks = bookmarkService.bookmarksListenable.value {
    _bookmarks = _bookmarkService.bookmarksListenable.value;
    _bookmarkService.bookmarksListenable.addListener(_onBookmarksUpdated);
  }

  @override
  void dispose() {
    _bookmarkService.bookmarksListenable.removeListener(_onBookmarksUpdated);
    super.dispose();
  }

  int get totalBookmarksLength {
    return _bookmarks.length;
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

  void addDateFilter(DateSortOrder dateOrder) {
    dateFilter = dateOrder;
    notifyListeners();
  }

  void clearDateFilter() {
    dateFilter = null;
    notifyListeners();
  }

  void removeBookmark(BookmarkEntity item) {
    _bookmarkService.removeItem(item.id);
  }

  void _onBookmarksUpdated() {
    _bookmarks = _bookmarkService.bookmarksListenable.value;
    _bookmarks.sort((a, b) => b.bookmarkedDate.compareTo(a.bookmarkedDate));
    notifyListeners();
  }

  void updateBookmarkNote(BookmarkEntity item, String? newNote) {
    item.note = newNote;
    item.save();
    reload = !reload;
    notifyListeners();
  }

  void clearBookmarks() {
    _bookmarkService.clearBox();
  }
}
