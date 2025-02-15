//used in movie or tv credits.
import 'package:dio/dio.dart';
import 'package:imdb_app/models/simple_credit.dart';

// /tv/:series_id/credits
// /movie/:movie_id/credits
mixin CreditsMixin{
  //mediaName can be tv or movie, will be used to create request path
   Future<List<SimpleCredit>?> fetchCredits(
      {required int mediaID,
      required Dio dio,
      required String mediaType}) async {
    try {
      Response response =
          await dio.get("$mediaType/${mediaID.toString()}/credits");
      if (response.statusCode == 200) {
        final resultsList = response.data["cast"];
        //where condition is for creating objects from only
        //json objects that department is equal to acting.
        final simpleCreditList = List<SimpleCredit>.from(resultsList
            .where(
                (item) => item["known_for_department"].toString() == "Acting")
            .map((item) => SimpleCredit.fromJson(item)));

        if(simpleCreditList.isNotEmpty){
          return simpleCreditList;
        }
        return null;
      }
      return null;
    } catch (e) {
      print("Error at fetchCreditsWithID $e");
    }
    return null;
  }
}
