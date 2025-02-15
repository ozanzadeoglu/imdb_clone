// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_list_tile_media.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SimpleListTileMediaAdapter extends TypeAdapter<SimpleListTileMedia> {
  @override
  final int typeId = 1;

  @override
  SimpleListTileMedia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SimpleListTileMedia(
      knownForDepartment: fields[4] as String?,
      releaseDate: fields[5] as String?,
      mostKnownMedia: fields[6] as String?,
      id: fields[0] as int,
      posterPath: fields[1] as String?,
      name: fields[2] as String,
      mediaType: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SimpleListTileMedia obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.posterPath)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.mediaType)
      ..writeByte(4)
      ..write(obj.knownForDepartment)
      ..writeByte(5)
      ..write(obj.releaseDate)
      ..writeByte(6)
      ..write(obj.mostKnownMedia);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimpleListTileMediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
