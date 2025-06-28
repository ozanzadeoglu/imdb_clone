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
import 'package:imdb_app/views/tv_series/details/tv_series_details_controller.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

part 'widgets/_title_and_info.dart';
part 'widgets/_episode_guide_row.dart';

class TvSeriesDetailsView extends StatefulWidget {

  const TvSeriesDetailsView(
      {super.key});

  @override
  State<TvSeriesDetailsView> createState() => _TvSeriesDetailsViewState();
}

class _TvSeriesDetailsViewState extends State<TvSeriesDetailsView> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
        final vm = context.read<TvSeriesDetailsController>();
    final isLoading =
        context.select<TvSeriesDetailsController, bool>((vm) => vm.isLoading);

    return Scaffold(
      appBar: AppBar(title: Text(vm.tvSeriesName), centerTitle: false),
      body: (!isLoading && vm.tvSeries != null) ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Paddings.medium.value,
                      //vertical: Paddings.lowlow.value,
                    ),
                    child: _TitleAndInfo(tvSeries: vm.tvSeries!),
                  ),
                  _EpisodeGuideRow(tvSeries: vm.tvSeries!),
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
                              path: vm.tvSeries!.backdropPath),
                        )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.low.value),
                    child: PosterAndOverviewRow(
                        overview: vm.tvSeries!.overview,
                        posterPath: vm.tvSeries!.posterPath),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.lowlow.value),
                    child: SizedBox(
                      height: OtherSizes.genreContainerHeight.value,
                      child: SlideableGenre(genreList: vm.tvSeries!.genres!),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Paddings.low.value),
                    child: const Divider(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.lowlow.value),
                    child: PopularityRow(
                        popularity: vm.tvSeries!.popularity,
                        voteAverage: vm.tvSeries!.voteAverage,
                        voteCount: vm.tvSeries!.voteCount),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Paddings.low.value),
                    child: const Divider(),
                  ),

                  PosterCardWrapper<SimpleCredit>(
                    title: StringConstants.cast,
                    future: vm.tvSeriesCredits,
                  ),
                ],
              ),
            ) : const Center(child: LoadingWidget())
          
      
    );
  }
}
