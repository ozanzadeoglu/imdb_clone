// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarked_people.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkedPeopleAdapter extends TypeAdapter<BookmarkedPeople> {
  @override
  final int typeId = 8;

  @override
  BookmarkedPeople read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkedPeople(
      bookmarkedDate: fields[1] as DateTime,
      person: fields[3] as People,
    )..note = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, BookmarkedPeople obj) {
    writer
      ..writeByte(5)
      ..writeByte(3)
      ..write(obj.person)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bookmarkedDate)
      ..writeByte(2)
      ..write(obj.mediaType)
      ..writeByte(4)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkedPeopleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
