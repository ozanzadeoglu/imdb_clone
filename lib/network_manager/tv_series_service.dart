import 'package:dio/dio.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/simple_credit.dart';
import 'package:imdb_app/models/simple_tv_series_episode.dart';
import 'package:imdb_app/models/tv_series.dart';
import 'package:imdb_app/network_manager/credits_mixin.dart';
import 'package:imdb_app/network_manager/dio_client.dart';

abstract class ITvSeriesService {
  Future<TVSeries?> fetchTVSeriesDetailsWithID({required int tvSeriesID});
  Future<List<SimpleCredit>?> fetchCreditsWithID({required int tvSeriesID});
  Future<List<SimpleTvSeriesEpisode>?> fetchEpisodes({required int tvSeriesID, required int seasonNumber});
}

class TvSeriesService with CreditsMixin implements ITvSeriesService {
  final Dio _dio = DioClient.instance.dio;

  @override
  Future<TVSeries?> fetchTVSeriesDetailsWithID(
      {required int tvSeriesID}) async {
    try {
      var response = await _dio.get("${MediaTypes.tv.value}/$tvSeriesID");
      if (response.statusCode == 200) {
        return TVSeries.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error at fetchTVSeriesDetailsWithID $e");
    }
    return null;
  }

  @override
  Future<List<SimpleCredit>?> fetchCreditsWithID({required int tvSeriesID}) {
    //comes from CreditsMixin
    return fetchCredits(
        mediaID: tvSeriesID, dio: _dio, mediaType: MediaTypes.tv.value);
  }

  @override
  Future<List<SimpleTvSeriesEpisode>?> fetchEpisodes(
      {required int tvSeriesID, required int seasonNumber}) async {
    try {
      var response = await _dio
          .get("${MediaTypes.tv.value}/$tvSeriesID/season/$seasonNumber");
      if (response.statusCode == 200) {
        if (response.data != null && response.data['episodes'] != null) {
          // Map the episodes to a list of SimpleTvSeriesEpisode objects
          List<dynamic> episodesJson = response.data['episodes'];
          List<SimpleTvSeriesEpisode> episodes = episodesJson
              .map((episode) => SimpleTvSeriesEpisode.fromJson(
                  episode as Map<String, dynamic>))
              .toList();
          return episodes;
        }
        return null;
      }
      return null;
    } catch (e) {
      print("Error at fetchEpisodes: $e");
    }
    return null;
  }
}
