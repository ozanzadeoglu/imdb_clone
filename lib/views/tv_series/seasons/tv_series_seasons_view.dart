import 'package:flutter/material.dart';
import 'package:imdb_app/components/common/custom_poster_network_image.dart';
import 'package:imdb_app/components/common/loading_widget.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/views/tv_series/seasons/tv_series_seasons_controller.dart';
import 'package:imdb_app/enums/other_sizes.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/simple_tv_series_episode.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

part 'widgets/_episode_tile.dart';
part 'widgets/_season_container.dart';

class TvSeriesSeasonsView extends StatefulWidget {
  const TvSeriesSeasonsView({super.key});

  @override
  State<TvSeriesSeasonsView> createState() => _TvSeriesSeasonsViewState();
}

class _TvSeriesSeasonsViewState extends State<TvSeriesSeasonsView> {
  late PageController _pageController;
  late ScrollController _scrollController;

  @override
  void initState() {
    _pageController = context.read<TvSeriesSeasonsController>().pageController;
    _scrollController =
        context.read<TvSeriesSeasonsController>().scrollController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TvSeriesSeasonsController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${StringConstants.tvSeriesSeasons} (${controller.numberOfSeasons})"),
      ),
      body: Column(
        children: [
          SeasonSelectionListView(
            scrollController: _scrollController,
            controller: controller,
          ),
          Expanded(
            child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: controller.numberOfSeasons,
                onPageChanged: (value) {
                  controller.changeSelectedBox(value);
                  controller.calculateSeasonNumberListViewOffset(context);
                },
                itemBuilder: (context, index) {
                  return _SeasonEpisodesList(seasonNumber: index + 1);
                }),
          ),
        ],
      ),
    );
  }
}

class SeasonSelectionListView extends StatelessWidget {
  const SeasonSelectionListView({
    super.key,
    required ScrollController scrollController,
    required this.controller,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final TvSeriesSeasonsController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: OtherSizes.tvSeriesSeasonsContainerHeight.value,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: controller.numberOfSeasons,
        itemBuilder: (context, index) {
          return _SeasonContainer(index: index);
        },
      ),
    );
  }
}

class _SeasonEpisodesList extends StatelessWidget {
  final int seasonNumber;
  const _SeasonEpisodesList ({required this.seasonNumber});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TvSeriesSeasonsController>();
    final List<SimpleTvSeriesEpisode>? episodesList =
        context.select<TvSeriesSeasonsController, List<SimpleTvSeriesEpisode>?>(
            (controller) => controller.seasonsAndEpisodes[seasonNumber]);
    final bool isFetching = context.select<TvSeriesSeasonsController, bool>(
        (controller) => controller.isFetching);

    if (episodesList == null && isFetching == false) {
      //Used addPostFrameCallBack so fetchEpisodes called after widgets are built.
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => controller.fetchEpisodes(seasonNumber: seasonNumber));
    }

    //TODO: When swapping action starts and target is an unfetched season,
    //the current season which is fetched, rebuilts. This happens because of
    //the isFetching variable which turns to true. Although the same isFetching
    //variable is responsible for rebuilding the widget when fetching is done.
    //although the episodesList variable is initialized using context.select,
    //no notifiy is dispatch because although new data is added to but reference
    //is unchanged. Check if this action creates an overhead using profile mode of
    //debugging tool.
    return (episodesList != null)
        ? ListView.builder(
            itemCount: episodesList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: context.sized.height * 0.30,
                      minHeight: context.sized.height * 0.10,
                      maxWidth: double.infinity,
                      minWidth: double.infinity,
                    ),
                    child: _EpisodeTile(
                        episode: episodesList[index], episodeNum: index),
                  ),
                  const Divider(),
                ],
              );
            },
          )
        : const LoadingWidget();
  }
}
