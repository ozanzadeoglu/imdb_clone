import 'package:dio/dio.dart';
import 'package:imdb_app/models/simple_list_tile_media.dart';
import 'package:imdb_app/services/dio_client.dart';



class SearchService {
  final Dio _dio = DioClient.instance.dio;

  Future<List<SimpleListTileMedia>?> fetchMultiSearch(String query) async {
  try {
    Response response = await _dio.get(
      "search/multi",
      queryParameters: {"query": query, "page": "1"},
    );
    if (response.statusCode == 200) {
      final resultsList = response.data["results"] as List;

      final listTileMediaList = List<SimpleListTileMedia>.from(
        resultsList.map((e) {
          try {
            return SimpleListTileMedia.fromJson(e);
          } catch (e) {
            print("Error processing element: $e");
            return null; // Skip invalid elements
          }
        }).where((element) => element != null), // Remove null entries
      );

      return listTileMediaList;
    }
    return null;
  } catch (e) {
    print("Error at fetchMultiSearch $e");
  }
  return null;
}


  // Future<List<SimpleListTileMedia>?> fetchMultiSearch(String query) async {
  //   try {
  //     Response response = await _dio.get(
  //       "search/multi",
  //       queryParameters: {"query": query, "page": "1"},
  //     );
  //     if (response.statusCode == 200) {
  //       final resultsList = response.data["results"] as List;
  //       print(resultsList);

  //       final listTileMediaList = List<SimpleListTileMedia>.from(
  //         resultsList.map(
  //           (e) => SimpleListTileMedia.fromJson(e),
  //         ),
  //       );
  //       return listTileMediaList;
  //     }
  //     return null;
  //   } catch (e) {
  //     print("Error at fetchMultiSearch $e");
  //   }
  //   return null;
  // }
}
