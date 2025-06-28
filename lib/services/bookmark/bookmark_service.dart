import 'package:hive/hive.dart';
import 'package:imdb_app/constants/box_names.dart';
import 'package:imdb_app/local_database_managers/hive_manager.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';


abstract class IBookmarkService {
  List<BookmarkEntity>? fetchValues();
  Future<void> putItem(String key, BookmarkEntity item);
  Future<void> removeItem(String key);
}

class BookmarkService extends IHiveManager<BookmarkEntity> implements IBookmarkService{
  BookmarkService() : super(BoxNames.bookmarkBox);

  @override
  List<BookmarkEntity>? fetchValues() {
    return box.values.toList();
  }

  @override
  Future<void> putItem(String key, BookmarkEntity item) async {
    await box.put(key, item);
  }
  
  @override
  Future<void> removeItem(String key) async {
    await box.delete(key);
  }
}
