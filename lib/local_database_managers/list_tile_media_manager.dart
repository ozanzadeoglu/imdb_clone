import 'package:imdb_app/constants/box_names.dart';
import 'package:imdb_app/local_database_managers/hive_manager.dart';
import 'package:imdb_app/models/search/simple_list_tile_media_history.dart';

class ListTileMediaManager extends IHiveManager<SimpleListTileMediaHistory> {
  ListTileMediaManager() : super(BoxNames.resentSearchBox);

  @override
  List<SimpleListTileMediaHistory>? fetchValues() {
    return box?.values.toList();
  }

  @override
  Future<void> putItem(String key, SimpleListTileMediaHistory item) async {
    await box?.put(key, item);
  }

}
