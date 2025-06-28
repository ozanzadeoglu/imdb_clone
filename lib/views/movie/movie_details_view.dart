import 'package:flutter/material.dart';
import 'package:imdb_app/components/common/custom_backdrop_network_image.dart';
import 'package:imdb_app/components/common/loading_widget.dart';
import 'package:imdb_app/components/media/bookmark_button.dart';
import 'package:imdb_app/components/media/grey_info_label.dart';
import 'package:imdb_app/components/media/popularity_row.dart';
import 'package:imdb_app/components/common/poster_card_wrapper.dart';
import 'package:imdb_app/components/media/poster_and_overview_row.dart';
import 'package:imdb_app/components/media/slideable_genre.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/extensions/better_display.dart';
import 'package:imdb_app/enums/other_sizes.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/movie.dart';
import 'package:imdb_app/models/simple_credit.dart';
import 'package:imdb_app/views/movie/movie_details_controller.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

part 'widgets/_title_and_info.dart';

class MovieDetailsView extends StatefulWidget {
  const MovieDetailsView({super.key});

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    final vm = context.read<MovieDetailsController>();
    final isLoading =
        context.select<MovieDetailsController, bool>((vm) => vm.isLoading);
    final isBookmarked =
        context.select<MovieDetailsController, bool>((vm) => vm.isBookmarked);
    return Scaffold(
      appBar: AppBar(title: Text(vm.movieTitle), centerTitle: false),
      body: (!isLoading && vm.movie != null)
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.lowlow.value),
                    child: _TitleAndInfo(movie: vm.movie!),
                  ),
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
                              path: vm.movie!.backdropPath),
                        )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.low.value),
                    child: PosterAndOverviewRow(
                      overview: vm.movie!.overview,
                      posterPath: vm.movie!.posterPath,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.lowlow.value),
                    child: SizedBox(
                      height: OtherSizes.genreContainerHeight.value,
                      child: SlideableGenre(genreList: vm.movie!.genres!),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Paddings.medium.value,
                      vertical: Paddings.low.value,
                    ),
                    child: BookmarkButton(
                      isBookmarked: isBookmarked,
                      onTap: vm.addOrRemoveBookmark,
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.lowlow.value),
                    child: PopularityRow(
                        popularity: vm.movie!.popularity,
                        voteAverage: vm.movie!.voteAverage,
                        voteCount: vm.movie!.voteCount),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Paddings.low.value),
                    child: const Divider(),
                  ),
                  PosterCardWrapper<SimpleCredit>(
                    title: StringConstants.cast,
                    future: vm.movieCredits,
                  ),
                ],
              ),
            )
          : const LoadingWidget(),
    );
  }
}
