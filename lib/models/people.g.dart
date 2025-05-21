// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeopleAdapter extends TypeAdapter<People> {
  @override
  final int typeId = 7;

  @override
  People read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return People(
      id: fields[0] as int?,
      name: fields[1] as String?,
      knownForDepartment: fields[2] as String?,
      birthday: fields[3] as String?,
      deathDay: fields[4] as String?,
      biography: fields[5] as String?,
      imagePath: fields[6] as String?,
      gender: fields[7] as String?,
      placeOfBirth: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, People obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.knownForDepartment)
      ..writeByte(3)
      ..write(obj.birthday)
      ..writeByte(4)
      ..write(obj.deathDay)
      ..writeByte(5)
      ..write(obj.biography)
      ..writeByte(6)
      ..write(obj.imagePath)
      ..writeByte(7)
      ..write(obj.gender)
      ..writeByte(8)
      ..write(obj.placeOfBirth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeopleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
