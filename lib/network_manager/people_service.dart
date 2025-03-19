import 'package:dio/dio.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/people.dart';
import 'package:imdb_app/models/poster_card_media.dart';
import 'package:imdb_app/network_manager/dio_client.dart';

abstract class IPeopleService {
  Future<People?> fetchPeopleDetailsWithID({required int peopleID});
  Future<List<PosterCardMedia>?> fetchPeopleKnownFor(
      {required String peopleName});
  Future<List<PosterCardMedia>?> fetchPopularPeople();
}

class PeopleService implements IPeopleService {
  final Dio _dio = DioClient.instance.dio;

  @override
  Future<People?> fetchPeopleDetailsWithID({required int peopleID}) async {
    try {
      var response = await _dio.get("${MediaTypes.person.value}/$peopleID");
      if (response.statusCode == 200) {
        return People.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("Error at fetchPeopleDetailsWithID $e");
    }
    return null;
  }

  //so this method is little may come a little bit off.
  //known_for list which the consists of the most known media that a people
  //had part of can be only achieved via searching. And not from people
  //details API. This is why I use search api with exact query of person's name
  //hope that there's no one with the same name as him, extract first element
  //of the results list, which supposedly have multiple person's in it. Then from that
  //element which is supposedly the actor we're looking for then return his known_for
  //list to list of simplePosterCardMedia.
  @override
  Future<List<PosterCardMedia>?> fetchPeopleKnownFor(
      {required String peopleName}) async {
    try {
      var response = await _dio.get(
        "search/${MediaTypes.person.value}",
        queryParameters: {"query": peopleName},
      );
      if (response.statusCode == 200) {
        var knownForList = ((response.data["results"] as List).first
            as Map<String, dynamic>)["known_for"] as List;

        if (knownForList.isNotEmpty) {
          List<PosterCardMedia> simpleKnownForList =
              List<PosterCardMedia>.from(knownForList
                  .map((item) => PosterCardMedia.fromJson(item)));

          return simpleKnownForList;
        }
        return null;
      }
      return null;
    } catch (e) {
      print("Error at fetchPeopleDetailsWithID $e");
    }
    return null;
  }

  @override
  Future<List<PosterCardMedia>?> fetchPopularPeople() async {
    try {
      var response = await _dio.get(
        "${MediaTypes.person.value}/popular",
      );
      if (response.statusCode == 200) {
        var popularList = (response.data["results"] as List);

        if (popularList.isNotEmpty) {
          List<PosterCardMedia> simplepopularList =
              List<PosterCardMedia>.from(popularList.map((item) =>
                  PosterCardMedia.fromJsonWithType(
                      item, MediaTypes.person.value)));

          return simplepopularList;
        }
        return null;
      }
      return null;
    } catch (e) {
      print("Error at fetchPeopleDetailsWithID $e");
    }
    return null;
  }
}
