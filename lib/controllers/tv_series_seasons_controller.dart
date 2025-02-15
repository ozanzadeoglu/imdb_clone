import 'package:flutter/material.dart';
import 'package:imdb_app/models/simple_tv_series_episode.dart';
import 'package:imdb_app/network_manager/tv_series_service.dart';
import 'package:kartal/kartal.dart';

//I guess this thing is not an exact part of MVC or MVVM, this class will
//used for sharing data across TvSeriesSeasonsController's childs and itself.
//I guess service calls should be done here too, unlike MovieDetailsView or TvSeriesDetails.
//also this one will not be top level provider because it will be only used on descandants of
//TvSeriesSeasons.
class TvSeriesSeasonsController with ChangeNotifier {
  final int numberOfSeasons;
  final int tvSeriesID;
  int _selectedItem = 0;
  double listViewCurrentOffset = 0;

  List<SimpleTvSeriesEpisode> episodesList = [];
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ITvSeriesService _service = TvSeriesService();

  int get selectedItem => _selectedItem;
  PageController get pageController => _pageController;
  ScrollController get scrollController => _scrollController;

  TvSeriesSeasonsController(
      {required this.numberOfSeasons, required this.tvSeriesID}) {
    fetchEpisodes(tvSeriesID: tvSeriesID, seasonNumber: _selectedItem+1);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void changeSelectedBox(newIndex) {
    _selectedItem = newIndex;
    notifyListeners();
  }

  //if there's five or more than five seasons, total of 5
  //boxes should take all the width, if there's less than 5,
  //number of seasons(ex. 4) should take all the width
  double calculateSeasonBoxWidth(BuildContext context) {
    if (5 <= numberOfSeasons) {
      return context.sized.width * 1 / 5;
    } else {
      return context.sized.width / numberOfSeasons;
    }
  }

  void calculateSeasonNumberListViewOffset(
    BuildContext context,
  ) {
    if (5 <= numberOfSeasons &&
        3 <= selectedItem &&
        selectedItem <= (numberOfSeasons - 3)) {
      final seasonBoxWidth = calculateSeasonBoxWidth(context);
      if (3 <= selectedItem) {
        scrollController.jumpTo(seasonBoxWidth * (selectedItem - 2));
      }
    }
  }

  void fetchEpisodes(
      {required int tvSeriesID, required int seasonNumber}) async {
    final response = await _service.fetchEpisodes(
        tvSeriesID: tvSeriesID, seasonNumber: seasonNumber);
    if (response != null) {
      //episodesList.addAll(response);
      episodesList = response;
    }
    notifyListeners();
  }

  void clearEpisodesList() {
    episodesList = [];
    notifyListeners();
  }
}
