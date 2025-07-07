import 'package:flutter/foundation.dart';
import 'package:imdb_app/constants/box_names.dart';
import 'package:imdb_app/local_database_managers/hive_manager.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';

abstract class IBookmarkService {
  ValueListenable<List<BookmarkEntity>> get bookmarksListenable;
  List<BookmarkEntity>? fetchValues();
  Future<void> putItem(String key, BookmarkEntity item);
  Future<void> removeItem(String key);
  bool isBookmarked({required String movieID});
  Future<void> updateBookmarkNote(BookmarkEntity item, String? newNote);
  Future<void> clearBox();
  void dispose();
}

class BookmarkService extends IHiveManager<BookmarkEntity>
    implements IBookmarkService {
  late final ValueNotifier<List<BookmarkEntity>> _bookmarksNotifier;

  BookmarkService() : super(BoxNames.bookmarkBox) {
    _bookmarksNotifier = ValueNotifier(box.values.toList());
  }

  @override
  ValueListenable<List<BookmarkEntity>> get bookmarksListenable =>
      _bookmarksNotifier;

  void _updateNotifier() {
    _bookmarksNotifier.value = fetchValues();
  }

  @override
  Future<void> updateBookmarkNote(BookmarkEntity item, String? newNote) async {
    item.note = newNote;
    await item.save();
    _updateNotifier();
  }

  @override
  List<BookmarkEntity> fetchValues() {
    return box.values.toList();
  }

  @override
  bool isBookmarked({required String movieID}) {
    return box.containsKey(movieID);
  }

  @override
  Future<void> putItem(String key, BookmarkEntity item) async {
    await box.put(key, item);
    _updateNotifier();
  }

  @override
  Future<void> removeItem(String key) async {
    await box.delete(key);
    _updateNotifier();
  }

  @override
  void dispose() {
    _bookmarksNotifier.dispose();
  }
}
