import 'package:dio/dio.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/movie.dart';
import 'package:imdb_app/models/simple_credit.dart';
import 'package:imdb_app/services/credits_mixin.dart';
import 'package:imdb_app/services/dio_client.dart';

abstract class IMovieService{
  Future<Movie?> fetchMovieDetailsWithID({required int movieID});
  Future<List<SimpleCredit>?> fetchCreditsWithID({required int movieID});
}

class MovieService with CreditsMixin implements IMovieService{
  final Dio _dio = DioClient.instance.dio;

  @override
  Future<Movie?> fetchMovieDetailsWithID({required int movieID}) async {
    try{
      var response = await _dio.get("${MediaTypes.movie.value}/$movieID");
      if(response.statusCode == 200){
        return Movie.fromJson(response.data);
      }
        return null;
    }
    catch(e){
      print("Error at fetchMovieDetailsWithID $e");
    }
    return null;
  }

  @override
  Future<List<SimpleCredit>?> fetchCreditsWithID({required int movieID}){
    //comes from CreditsMixin
    return fetchCredits(mediaID: movieID, dio: _dio, mediaType: MediaTypes.movie.value);
  }
}