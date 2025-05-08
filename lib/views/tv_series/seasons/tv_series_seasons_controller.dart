import 'package:flutter/material.dart';
import 'package:imdb_app/models/simple_tv_series_episode.dart';
import 'package:imdb_app/services/tv_series_service.dart';
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
    Map<int, List<SimpleTvSeriesEpisode>?> seasonsAndEpisodes = {};
    //List<SimpleTvSeriesEpisode> episodesList = [];
    final ScrollController _scrollController = ScrollController();
    final PageController _pageController = PageController();
    final ITvSeriesService _service = TvSeriesService();
    bool isFetching = false;

    int get selectedItem => _selectedItem;
    PageController get pageController => _pageController;
    ScrollController get scrollController => _scrollController;

    TvSeriesSeasonsController(
        {required this.numberOfSeasons, required this.tvSeriesID}) {
      //fetchEpisodes(seasonNumber: _selectedItem + 1);
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
          1 <= selectedItem &&
          selectedItem <= (numberOfSeasons - 3)) {
        final seasonBoxWidth = calculateSeasonBoxWidth(context);
        if (2 <= selectedItem) {
          scrollController.jumpTo(seasonBoxWidth * (selectedItem - 2));
        }
      }
    }

    void fetchEpisodes({required int seasonNumber}) async {
      if (seasonsAndEpisodes.containsKey(seasonNumber) == true) {
        return;
      } else {
        isFetching = true;
        notifyListeners();
        seasonsAndEpisodes[seasonNumber] =
            await _fetchEpisodesFromService(seasonNumber: seasonNumber);
        isFetching = false;
        notifyListeners();
      }
    }

    //fetches adjacent seasons for better user experience. UPDATE: This function
    //becomes a hindarance when user swipes between new screens fast, so I commented
    //it out for now, I may return to creating a new solution.
    // void preloadAdjacentSeaons(int seasonNumber) async {
    //   if (seasonNumber < numberOfSeasons) {
    //     final nextSeason = seasonNumber + 1;
    //     if (!seasonsAndEpisodes.containsKey(nextSeason)) {
    //       seasonsAndEpisodes[nextSeason] = await _fetchEpisodesFromService(seasonNumber: nextSeason);
    //       print("fetched next $nextSeason");
    //     }
    //   }
    //   if (seasonNumber > 1) {
    //     final prevSeason = seasonNumber - 1;
    //     if (!seasonsAndEpisodes.containsKey(prevSeason)) {
    //       seasonsAndEpisodes[prevSeason] = await _fetchEpisodesFromService(seasonNumber: prevSeason);
    //       print("fetched previous $prevSeason");
    //     }
    //   }
    // }

    //helper function to reduce code duplication this method is 
    //used both in preloadAdjacentSeaons and fetchEpisodes
    Future<List<SimpleTvSeriesEpisode>?> _fetchEpisodesFromService(
        {required int seasonNumber}) async {
      final response = await _service.fetchEpisodes(
          tvSeriesID: tvSeriesID, seasonNumber: seasonNumber);
      if (response != null) {
        return response;
      }
      return null;
    }
  }
