// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarked_tv_series.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkedTvSeriesAdapter extends TypeAdapter<BookmarkedTvSeries> {
  @override
  final int typeId = 6;

  @override
  BookmarkedTvSeries read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkedTvSeries(
      bookmarkedDate: fields[1] as DateTime,
      tvSeries: fields[3] as TVSeries,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkedTvSeries obj) {
    writer
      ..writeByte(4)
      ..writeByte(3)
      ..write(obj.tvSeries)
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
      other is BookmarkedTvSeriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
