import 'package:flutter/material.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/bookmark/bookmarked_people.dart';
import 'package:imdb_app/models/people.dart';
import 'package:imdb_app/models/poster_card_media.dart';
import 'package:imdb_app/services/bookmark/bookmark_service.dart';
import 'package:imdb_app/services/people_service.dart';

class PeopleDetailsController extends ChangeNotifier {
  final IPeopleService _peopleService;
  final IBookmarkService _bookmarkService;

  final int peopleID;
  final String peopleName;

  late final People? _people;
  late final Future<List<PosterCardMedia>?> _knownForList;

  bool _isLoading = true;
  bool _isBookmarked = false;

  People? get people => _people;
  Future<List<PosterCardMedia>?> get knownForList => _knownForList;

  bool get isLoading => _isLoading;
  bool get isBookmarked => _isBookmarked;

  PeopleDetailsController({
    required this.peopleID,
    required this.peopleName,
    required bookmarkService,
    required peopleService,
  })  : _bookmarkService = bookmarkService,
        _peopleService = peopleService {
    _isBookmarked = _checkIfBookmarked();
    _fetchPageData();
  }

  void addOrRemoveBookmark() {
    if (!_isBookmarked) {
      _addBookmark();
    } else {
      _removeBookmark();
    }
    _isBookmarked = _checkIfBookmarked();
    notifyListeners();
  }

  //functions below are file private, only functions and variables above will be used in view.

  void _addBookmark() {
    if (_people != null) {
      final bookmarkedPeople =
          BookmarkedPeople(bookmarkedDate: DateTime.now(), person: people!);
      _bookmarkService.putItem(bookmarkedPeople.id, bookmarkedPeople);
    }
  }

  void _removeBookmark() {
    _bookmarkService.removeItem("${MediaTypes.person.value}_$peopleID");
  }

  bool _checkIfBookmarked() {
    return _bookmarkService.isBookmarked(movieID: "${MediaTypes.person.value}_$peopleID");
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
    final response =
        await _peopleService.fetchPeopleKnownFor(peopleName: peopleName);

    if (response != null) {
      return response;
    }
    return null;
  }
}
