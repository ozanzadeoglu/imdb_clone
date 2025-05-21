// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarked_movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkedMovieAdapter extends TypeAdapter<BookmarkedMovie> {
  @override
  final int typeId = 4;

  @override
  BookmarkedMovie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkedMovie(
      bookmarkedDate: fields[1] as DateTime,
      movie: fields[3] as Movie,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkedMovie obj) {
    writer
      ..writeByte(4)
      ..writeByte(3)
      ..write(obj.movie)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bookmarkedDate)
      ..writeByte(2)
      ..write(obj.mediaType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkedMovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
