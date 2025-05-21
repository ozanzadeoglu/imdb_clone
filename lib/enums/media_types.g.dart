// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaTypesAdapter extends TypeAdapter<MediaTypes> {
  @override
  final int typeId = 10;

  @override
  MediaTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MediaTypes.movie;
      case 1:
        return MediaTypes.tv;
      case 2:
        return MediaTypes.person;
      default:
        return MediaTypes.movie;
    }
  }

  @override
  void write(BinaryWriter writer, MediaTypes obj) {
    switch (obj) {
      case MediaTypes.movie:
        writer.writeByte(0);
        break;
      case MediaTypes.tv:
        writer.writeByte(1);
        break;
      case MediaTypes.person:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
