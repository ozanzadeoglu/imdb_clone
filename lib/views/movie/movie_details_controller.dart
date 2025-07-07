import 'package:flutter/material.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/bookmark/bookmarked_movie.dart';
import 'package:imdb_app/models/movie.dart';
import 'package:imdb_app/models/simple_credit.dart';
import 'package:imdb_app/services/bookmark/bookmark_service.dart';
import 'package:imdb_app/services/movie_service.dart';

class MovieDetailsController extends ChangeNotifier {
  final IMovieService _movieService;
  final IBookmarkService _bookmarkService;

  final int movieID;
  final String movieTitle;

  late final Movie? _movie;
  late final Future<List<SimpleCredit>?> _movieCredits;

  bool _isLoading = true;
  bool _isBookmarked = false;

  Movie? get movie => _movie;
  Future<List<SimpleCredit>?> get movieCredits => _movieCredits;

  bool get isLoading => _isLoading;
  bool get isBookmarked => _isBookmarked;

  MovieDetailsController(
      {required this.movieID,
      required this.movieTitle,
      required movieService,
      required bookmarkSerivce})
      : _movieService = movieService,
        _bookmarkService = bookmarkSerivce 
  {
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

  //below functions are file private, only functions and variables above will be used in view.

  void _addBookmark() {
    if (_movie != null) {
      final bookmarkedMovie =
          BookmarkedMovie(bookmarkedDate: DateTime.now(), movie: _movie);
      _bookmarkService.putItem(bookmarkedMovie.id, bookmarkedMovie);
    }
  }

  void _removeBookmark() {
    _bookmarkService.removeItem("${MediaTypes.movie.value}_$movieID");
  }

  bool _checkIfBookmarked() {
    return _bookmarkService.isBookmarked(movieID: "${MediaTypes.movie.value}_$movieID");
  }

  void _fetchPageData() async {
    _isLoading = true;
    notifyListeners();
    _movie = await _fetchMovieDetails();
    _movieCredits = _fetchCredits();
    _isLoading = false;
    notifyListeners();
  }

  Future<Movie?> _fetchMovieDetails() async {
    final response =
        await _movieService.fetchMovieDetailsWithID(movieID: movieID);
    if (response != null) {
      return response;
    }
    return null;
  }

  Future<List<SimpleCredit>?> _fetchCredits() async {
    final response = await _movieService.fetchCreditsWithID(movieID: movieID);
    if (response != null) {
      return response;
    }
    return null;
  }
}
