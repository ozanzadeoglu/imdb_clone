import 'package:flutter/material.dart';
import 'package:imdb_app/models/people.dart';
import 'package:imdb_app/models/poster_card_media.dart';
import 'package:imdb_app/services/people_service.dart';

class PeopleDetailsController extends ChangeNotifier {
  final IPeopleService _peopleService = PeopleService();

  final int peopleID;
  final String peopleName;

  late final People? _people;
  late final Future<List<PosterCardMedia>?> _knownForList;

  bool _isLoading = true;

  People? get people => _people;
  Future<List<PosterCardMedia>?> get knownForList => _knownForList;

  bool get isLoading => _isLoading;

  PeopleDetailsController({required this.peopleID, required this.peopleName}) {
    _fetchPageData();
  }

  void _fetchPageData() async {
    _isLoading = true;
    notifyListeners();
    _people = await _fetchPersonDetails();
    _knownForList = _fetchKnownList();
    _isLoading = false;
    notifyListeners();
  }

  Future<People?> _fetchPersonDetails() async {
    final response =
        await _peopleService.fetchPeopleDetailsWithID(peopleID: peopleID);
    if (response != null) {
      return response;
    }
    return null;
  }

  Future<List<PosterCardMedia>?> _fetchKnownList() async {
    final response = await _peopleService.fetchPeopleKnownFor(peopleName: peopleName);

    if (response != null) {
      return response;
    }
    return null;
  }

}