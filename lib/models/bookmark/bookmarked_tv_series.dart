import 'package:hive/hive.dart';
import 'package:imdb_app/constants/hive_adapters.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';
import 'package:imdb_app/models/tv_series.dart';

part 'bookmarked_tv_series.g.dart';

@HiveType(typeId: HiveAdapters.bookmarkedTvSeries)
class BookmarkedTvSeries extends BookmarkEntity {
  @HiveField(3)
  final TVSeries tvSeries;

  BookmarkedTvSeries({
    required super.bookmarkedDate,
    required this.tvSeries,
  }) : super(
          id: "${MediaTypes.tv.value}_${tvSeries.id}",
          mediaType: MediaTypes.tv,
        );

  @override
  String get title => tvSeries.name ?? "";
}
