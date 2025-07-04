import 'package:dio/dio.dart';
import 'package:imdb_app/models/simple_media.dart';
import 'package:imdb_app/models/poster_card_media.dart';
import 'package:imdb_app/services/dio_client.dart';

class TrendingService {
    final Dio _dio = DioClient.instance.dio;
     
    //nullable
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