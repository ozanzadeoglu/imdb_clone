  import 'package:hive/hive.dart';
  import 'package:imdb_app/models/simple_list_tile_media.dart';

  class HiveService {
    void openBox(String boxName) async {
      await Hive.openBox<Map<String, Object>>(boxName);
    }

    void closeBox(String boxName) async {
      await Hive.box<Map<String, Object>>(boxName).close();
    }

    void addToBox(String boxName, SimpleListTileMedia data) {
      var box = Hive.box<Map<String, Object>>(boxName);
      //box.add(data);
      box.put("${data.id}", <String, Object>{"data": data, "date": DateTime.now()});
    }

    List<Map<String, Object>> getEverythingFromBox(String boxName) {
      final List<Map<String, Object>> list =
          Hive.box<Map<String, Object>>(boxName).values.toList();

      list.sort((a, b) {
        final DateTime dateA = a['date'] as DateTime;
        final DateTime dateB = b['date'] as DateTime;
        return dateB.compareTo(dateA); 
      });
      return list;
    }

    void clearBox(String boxName) {
      Hive.box<Map<String, Object>>(boxName).clear();
    }
  }
