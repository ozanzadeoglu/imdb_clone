import 'package:flutter/material.dart';
import 'package:imdb_app/models/simple_credit.dart';
import 'package:imdb_app/models/tv_series.dart';
import 'package:imdb_app/services/tv_series_service.dart';

class TvSeriesDetailsController extends ChangeNotifier {
  final ITvSeriesService _tvSeriesservice = TvSeriesService();

  final int tvSeriesID;
  final String tvSeriesName;

  late final TVSeries? _tvSeries;
  late final Future<List<SimpleCredit>?> _tvSeriesCredits;

  bool _isLoading = true;

  TVSeries? get tvSeries => _tvSeries;
  Future<List<SimpleCredit>?> get tvSeriesCredits => _tvSeriesCredits;

  bool get isLoading => _isLoading;

  TvSeriesDetailsController({required this.tvSeriesID, required this.tvSeriesName}) {
    _fetchPageData();
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