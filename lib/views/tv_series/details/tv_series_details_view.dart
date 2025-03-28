import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/components/common/custom_backdrop_network_image.dart';
import 'package:imdb_app/components/common/loading_widget.dart';
import 'package:imdb_app/components/media/grey_info_label.dart';
import 'package:imdb_app/components/media/popularity_row.dart';
import 'package:imdb_app/components/common/poster_card_wrapper.dart';
import 'package:imdb_app/components/media/poster_and_overview_row.dart';
import 'package:imdb_app/components/media/slideable_genre.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/enums/other_sizes.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/extensions/better_display.dart';
import 'package:imdb_app/models/simple_credit.dart';
import 'package:imdb_app/models/tv_series.dart';
import 'package:imdb_app/network_manager/tv_series_service.dart';
import 'package:kartal/kartal.dart';

part 'widgets/_title_and_info.dart';
part 'widgets/_episode_guide_row.dart';

class TvSeriesDetailsView extends StatefulWidget {
  final int tvSeriesID;
  final String tvSeriesName;

  const TvSeriesDetailsView(
      {super.key, required this.tvSeriesID, required this.tvSeriesName});

  @override
  State<TvSeriesDetailsView> createState() => _TvSeriesDetailsViewState();
}

class _TvSeriesDetailsViewState extends State<TvSeriesDetailsView> {
  final ITvSeriesService _service = TvSeriesService();

  Future<TVSeries?> fetchTVSeriesDetails(int tvSeriesID) async {
    final response =
        await _service.fetchTVSeriesDetailsWithID(tvSeriesID: tvSeriesID);
    if (response != null) {
      return response;
    }
    return null;
  }

  Future<List<SimpleCredit>?> fetchCredits(int tvSeriesID) async {
    final response = await _service.fetchCreditsWithID(tvSeriesID: tvSeriesID);
    if (response != null) {
      return response;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.tvSeriesName), centerTitle: false),
      body: FutureBuilder(
        future: fetchTVSeriesDetails(widget.tvSeriesID),
        builder: (context, AsyncSnapshot<TVSeries?> snapshot) {
          if (snapshot.hasData) {
            final tvSeries = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Paddings.medium.value,
                      //vertical: Paddings.lowlow.value,
                    ),
                    child: _TitleAndInfo(tvSeries: tvSeries!),
                  ),
                  _EpisodeGuideRow(tvSeries: tvSeries),
                  mq.orientation == Orientation.portrait
                      ?
                      //show backdrop only when device is on portrait mode.
                      ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                            maxHeight: context.sized.width / 1.7777,
                            maxWidth: context.sized.width,
                          ),
                          child: CustomBackdropNetworkImage(
                              path: tvSeries.backdropPath),
                        )
                      : SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.low.value),
                    child: PosterAndOverviewRow(
                        overview: tvSeries.overview,
                        posterPath: tvSeries.posterPath),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.lowlow.value),
                    child: SizedBox(
                      height: OtherSizes.genreContainerHeight.value,
                      child: SlideableGenre(genreList: tvSeries.genres!),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Paddings.low.value),
                    child: Divider(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.lowlow.value),
                    child: PopularityRow(
                        popularity: tvSeries.popularity,
                        voteAverage: tvSeries.voteAverage,
                        voteCount: tvSeries.voteCount),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Paddings.low.value),
                    child: Divider(),
                  ),
                  castPosterCardListView(tvSeries),
                ],
              ),
            );
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }

  FutureBuilder<List<SimpleCredit>?> castPosterCardListView(TVSeries tvSeries) {
    return FutureBuilder(
      future: fetchCredits(tvSeries.id!),
      builder: (context, AsyncSnapshot<List<SimpleCredit>?> snapshot) {
        if (snapshot.hasData) {
          final actorList = snapshot.data;
          return PosterCardWrapper<SimpleCredit>(
              title: StringConstants.cast, list: actorList);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

