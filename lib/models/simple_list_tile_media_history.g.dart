// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_list_tile_media_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SimpleListTileMediaHistoryAdapter
    extends TypeAdapter<SimpleListTileMediaHistory> {
  @override
  final int typeId = 2;

  @override
  SimpleListTileMediaHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SimpleListTileMediaHistory(
      item: fields[0] as SimpleListTileMedia,
      accessedAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SimpleListTileMediaHistory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.item)
      ..writeByte(1)
      ..write(obj.accessedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimpleListTileMediaHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
