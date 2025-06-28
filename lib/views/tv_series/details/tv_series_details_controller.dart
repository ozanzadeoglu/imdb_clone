import 'package:flutter/material.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/bookmark/bookmarked_tv_series.dart';
import 'package:imdb_app/models/simple_credit.dart';
import 'package:imdb_app/models/tv_series.dart';
import 'package:imdb_app/services/bookmark/bookmark_service.dart';
import 'package:imdb_app/services/tv_series_service.dart';

class TvSeriesDetailsController extends ChangeNotifier {
  final ITvSeriesService _tvSeriesservice = TvSeriesService();
  final BookmarkService _bookmarkService = BookmarkService();

  final int tvSeriesID;
  final String tvSeriesName;

  late final TVSeries? _tvSeries;
  late final Future<List<SimpleCredit>?> _tvSeriesCredits;

  bool _isLoading = true;
  bool _isBookmarked = false;

  TVSeries? get tvSeries => _tvSeries;
  Future<List<SimpleCredit>?> get tvSeriesCredits => _tvSeriesCredits;

  bool get isLoading => _isLoading;
  bool get isBookmarked => _isBookmarked;

  TvSeriesDetailsController(
      {required this.tvSeriesID, required this.tvSeriesName}) {
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
    if (_tvSeries != null) {
      final bookmarkedTvSeries = BookmarkedTvSeries(
          bookmarkedDate: DateTime.now(), tvSeries: _tvSeries);
      _bookmarkService.putItem(bookmarkedTvSeries.id, bookmarkedTvSeries);
    }
  }

  void _removeBookmark() {
    _bookmarkService.removeItem("${MediaTypes.tv.value}_$tvSeriesID");
  }

  bool _checkIfBookmarked() {
    return _bookmarkService.box.keys
        .contains("${MediaTypes.tv.value}_$tvSeriesID");
  }

  void _fetchPageData() async {
    _isLoading = true;
    notifyListeners();
    _tvSeries = await _fetchTVSeriesDetails();
    _tvSeriesCredits = _fetchCredits();
    _isLoading = false;
    notifyListeners();
  }

  Future<TVSeries?> _fetchTVSeriesDetails() async {
    final response = await _tvSeriesservice.fetchTVSeriesDetailsWithID(
        tvSeriesID: tvSeriesID);
    if (response != null) {
      return response;
    }
    return null;
  }

  Future<List<SimpleCredit>?> _fetchCredits() async {
    final response =
        await _tvSeriesservice.fetchCreditsWithID(tvSeriesID: tvSeriesID);
    if (response != null) {
      return response;
    }
    return null;
  }
}
