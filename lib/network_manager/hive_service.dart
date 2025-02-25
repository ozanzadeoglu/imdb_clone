import 'package:hive/hive.dart';
import 'package:imdb_app/constants/box_names.dart';
import 'package:imdb_app/models/simple_list_tile_media.dart';
import 'package:imdb_app/models/simple_list_tile_media_history.dart';

class HiveService {
  void openBox(String boxName) async {
    await Hive.openBox<Map<String, Object>>(boxName);
  }

  void closeBox(String boxName) async {
    await Hive.box<Map<String, Object>>(boxName).close();
  }

  void addToBox(SimpleListTileMedia item) {
    var box = Hive.box<SimpleListTileMediaHistory>(BoxNames.resentSearchBox);
    final key = '${item.mediaType}_${item.id}';
    box.put(
      key,
      SimpleListTileMediaHistory(item: item, accessedAt: DateTime.now()),
    );
  }

  List<SimpleListTileMedia> getHistory()  {
    final box =  Hive.box<SimpleListTileMediaHistory>(BoxNames.resentSearchBox);
    final entries = box.values.toList();
    entries.sort((a, b) => b.accessedAt.compareTo(a.accessedAt));
    return entries.map((entry) => entry.item).toList();
  }


  void clearBox() {
    Hive.box<Map<String, Object>>(BoxNames.resentSearchBox).clear();
  }
}
