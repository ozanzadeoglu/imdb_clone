import 'package:hive_flutter/hive_flutter.dart';

abstract class IHiveManager<T> {
  final String boxName;
  late final Box<T> box;
  
  IHiveManager(this.boxName)  {
     box = Hive.box(boxName);
  }

  Future<void> clearBox() async {
    await box.clear();
  }

  List<T>? fetchValues();


  Future<void> putItem(String key, T item);
}
