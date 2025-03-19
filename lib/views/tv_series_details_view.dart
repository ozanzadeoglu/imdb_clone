import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/components/custom_backdrop_network_image.dart';
import 'package:imdb_app/components/loading_widget.dart';
import 'package:imdb_app/components/poster_card.dart';
import 'package:imdb_app/components/custom_poster_network_image.dart';
import 'package:imdb_app/components/grey_info_label.dart';
import 'package:imdb_app/components/poster_card_wrapper.dart';
import 'package:imdb_app/components/slideable_genre.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/enums/icon_sizes.dart';
import 'package:imdb_app/enums/image_sizes.dart';
import 'package:imdb_app/enums/other_sizes.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/extensions/better_display.dart';
import 'package:imdb_app/models/simple_credit.dart';
import 'package:imdb_app/models/tv_series.dart';
import 'package:imdb_app/network_manager/tv_series_service.dart';
import 'package:kartal/kartal.dart';

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
                    child: _TitleAndInfoColumn(tvSeries: tvSeries!),
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
                    child: _ImageAndOverviewRow(tvSeries: tvSeries),
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
                    child: _PopularityRow(
                        popularity: tvSeries.popularity!,
                        voteAverage: tvSeries.voteAverage!,
                        voteCount: tvSeries.voteCount!),
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
          return PosterCardWrapper(
            title: StringConstants.cast,
            listView: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: actorList?.length,
                itemBuilder: (context, index) {
                  final actor = actorList?[index];
                  return actor != null ? Padding(
                    padding: EdgeInsets.only(right: Paddings.low.value),
                    child: PosterCard.fromCredit(
                      simpleCredit: actor,
                    ),
                  ) : const SizedBox.shrink();
                },
              ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _ImageAndOverviewRow extends StatelessWidget {
  const _ImageAndOverviewRow({required this.tvSeries});

  final TVSeries tvSeries;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPosterNetworkImage(
          path: tvSeries.posterPath,
          height: ImageSizes.detailsHeight.value,
          width: ImageSizes.detailsWidth.value,
        ),
        SizedBox(width: context.sized.lowValue),
        Expanded(
          child: Text(
            tvSeries.overview ?? " ",
            style: Theme.of(context).textTheme.bodyMedium,
            // maxLines: 5,
            // overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _TitleAndInfoColumn extends StatelessWidget {
  const _TitleAndInfoColumn({
    required this.tvSeries,
  });

  final TVSeries tvSeries;

  String? editDateIfNotNull(String? date) {
    if (date != null) {
      if (date.isNotEmpty) {
        String editedDate = date;
        return editedDate.extractYear();
      }
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tvSeries.name!,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Row(
          children: [
            const GreyInfoLabel(data: StringConstants.tvSeries),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Paddings.medium.value),
              child: GreyInfoLabel(data: tvSeries.firstAirDate?.extractYear()),
            ),
            GreyInfoLabel(data: tvSeries.lastAirDate?.extractYear()),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Paddings.lowlow.value,
                  horizontal: Paddings.medium.value),
              child: GreyInfoLabel(data: tvSeries.status),
            ),
          ],
        ),
      ],
    );
  }
}

class _EpisodeGuideRow extends StatelessWidget {
  const _EpisodeGuideRow({required this.tvSeries});

  final TVSeries tvSeries;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (tvSeries.numberOfSeasons != null && tvSeries.id != null) {
              context.pushNamed(
                "seasons",
                queryParameters: {
                  'id': tvSeries.id.toString(),
                  'seasons': tvSeries.numberOfSeasons.toString()
                },
                pathParameters: {'id': tvSeries.id.toString()},
              );
            }
          },
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Paddings.medium.value,
                vertical: Paddings.lowHigh.value,
              ),
              child: const Text(
                StringConstants.tvSeriesEpisodeGuide,
                style: TextStyle(color: ColorConstants.iconYellow),
              ),
            ),
          ),
        ),
        GreyInfoLabel(
            data:
                "${tvSeries.numberOfEpisodes.toString()} ${StringConstants.tvSeriesEpisodes}")
      ],
    );
  }
}

class _PopularityRow extends StatelessWidget {
  final double popularity;
  final double voteAverage;
  final int voteCount;

  const _PopularityRow({
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Icon(Icons.favorite,
                color: ColorConstants.iconRed, size: IconSizes.medium.value),
            Text(popularity.toInt().toString(),
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        Column(
          children: [
            Icon(Icons.star,
                color: ColorConstants.iconYellow, size: IconSizes.medium.value),
            Text("${voteAverage.toStringAsFixed(1)}/10",
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        Column(
          children: [
            Icon(Icons.person,
                color: ColorConstants.iconBlue, size: IconSizes.medium.value),
            Text(voteCount.toString(),
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }
}
