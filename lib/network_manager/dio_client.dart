import 'package:dio/dio.dart';
import 'package:imdb_app/api_keys/api_keys.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3/",
      headers: {
        "Content-Type": "application/json",
        "Authorization": ApiKeys.tmdb,
      },
      queryParameters: {
        "language": "en-US"
      }
    ),
  );

  DioClient._internal();

  static final DioClient instance = DioClient._internal();

  Dio get dio => _dio;
}
