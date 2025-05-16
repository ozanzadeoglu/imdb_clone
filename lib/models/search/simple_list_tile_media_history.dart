// simple_list_tile_media_history.dart
import 'package:hive/hive.dart';
import 'simple_list_tile_media.dart';

part 'simple_list_tile_media_history.g.dart'; // Must match exactly

@HiveType(typeId: 2) // Unique type ID
class SimpleListTileMediaHistory {
  @HiveField(0)
  final SimpleListTileMedia item;
  
  @HiveField(1)
  final DateTime accessedAt;

  SimpleListTileMediaHistory({
    required this.item,
    required this.accessedAt,
  });
}