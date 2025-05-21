// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_series.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TVSeriesAdapter extends TypeAdapter<TVSeries> {
  @override
  final int typeId = 5;

  @override
  TVSeries read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TVSeries(
      backdropPath: fields[0] as String?,
      firstAirDate: fields[1] as String?,
      genres: (fields[2] as List?)?.cast<Genre>(),
      id: fields[3] as int?,
      inProduction: fields[4] as bool?,
      lastAirDate: fields[5] as String?,
      name: fields[6] as String?,
      numberOfEpisodes: fields[7] as int?,
      numberOfSeasons: fields[8] as int?,
      overview: fields[9] as String?,
      popularity: fields[10] as double,
      posterPath: fields[11] as String?,
      status: fields[12] as String?,
      voteAverage: fields[13] as double,
      voteCount: fields[14] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TVSeries obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.backdropPath)
      ..writeByte(1)
      ..write(obj.firstAirDate)
      ..writeByte(2)
      ..write(obj.genres)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.inProduction)
      ..writeByte(5)
      ..write(obj.lastAirDate)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.numberOfEpisodes)
      ..writeByte(8)
      ..write(obj.numberOfSeasons)
      ..writeByte(9)
      ..write(obj.overview)
      ..writeByte(10)
      ..write(obj.popularity)
      ..writeByte(11)
      ..write(obj.posterPath)
      ..writeByte(12)
      ..write(obj.status)
      ..writeByte(13)
      ..write(obj.voteAverage)
      ..writeByte(14)
      ..write(obj.voteCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TVSeriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
