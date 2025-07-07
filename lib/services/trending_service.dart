import 'package:dio/dio.dart';
import 'package:imdb_app/models/simple_media.dart';
import 'package:imdb_app/models/poster_card_media.dart';

abstract class ITrendingService{
  Future<List<SimpleMedia>?> fetchTrendingMedia({required String timeWindow});
  Future<List<PosterCardMedia>?> fetchTrendingAsPosterCard({required String timeWindow});
}

class TrendingService implements ITrendingService {
    final Dio _dio;
    
    TrendingService(this._dio);

    //nullable
    @override
    Future<List<SimpleMedia>?> fetchTrendingMedia({required String timeWindow}) async {//time_window can be day or week
      try{
        Response response = await _dio.get("trending/all/$timeWindow");
        if(response.statusCode == 200){
          var resultsList = response.data["results"];
          return List<SimpleMedia>.from(
          resultsList.map((item) => SimpleMedia.fromJson(item)),
        );

        }
        return null;
      }
      catch(e){
        print("Error at TrendingService $e");
      }
      return null;
    }
    @override
    Future<List<PosterCardMedia>?> fetchTrendingAsPosterCard({required String timeWindow}) async {//time_window can be day or week
      try{
        Response response = await _dio.get("trending/all/$timeWindow");
        if(response.statusCode == 200){
          var resultsList = response.data["results"];
          return List<PosterCardMedia>.from(
          resultsList.map((item) => PosterCardMedia.fromJson(item)),
        );
        }
        return null;
      }
      catch(e){
        print("Error at TrendingService $e");
      }
      return null;
    }
}