import 'package:flutter/material.dart';
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
import 'package:imdb_app/extensions/better_display.dart';
import 'package:imdb_app/enums/image_sizes.dart';
import 'package:imdb_app/enums/other_sizes.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/movie.dart';
import 'package:imdb_app/models/simple_credit.dart';
import 'package:imdb_app/network_manager/movie_service.dart';
import 'package:kartal/kartal.dart';

class MovieDetailsView extends StatefulWidget {
  final int movieID;
  final String movieTitle;

  const MovieDetailsView(
      {super.key, required this.movieID, required this.movieTitle});

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  final IMovieService _service = MovieService();

  Future<Movie?> fetchMovieDetails(int movieID) async {
    final response = await _service.fetchMovieDetailsWithID(movieID: movieID);
    if (response != null) {
      return response;
    }
    return null;
  }

  Future<List<SimpleCredit>?> fetchCredits(int movieID) async {
    final response = await _service.fetchCreditsWithID(movieID: movieID);
    if (response != null) {
      return response;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.movieTitle), centerTitle: false),
      body: FutureBuilder(
        future: fetchMovieDetails(widget.movieID),
        builder: (context, AsyncSnapshot<Movie?> snapshot) {
          if (snapshot.hasData) {
            final movie = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.lowlow.value),
                    child: _TitleAndInfoColumn(movie: movie!),
                  ),

                  mq.orientation == Orientation.portrait ?
                  //show backdrop only when device is on portrait mode. 
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                      maxHeight: context.sized.width / 1.7777,
                      maxWidth: context.sized.width,
                    ),
                    child: CustomBackdropNetworkImage(path: movie.backdropPath),
                  ) : SizedBox.shrink(),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.low.value),
                    child: _ImageAndOverviewRow(movie: movie),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.lowlow.value),
                    child: SizedBox(
                      height: OtherSizes.genreContainerHeight.value,
                      child: SlideableGenre(genreList: movie.genres!),
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
                        popularity: movie.popularity!,
                        voteAverage: movie.voteAverage!,
                        voteCount: movie.voteCount!),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Paddings.low.value),
                    child: Divider(),
                  ),

                  FutureBuilder(
                    future: fetchCredits(movie.id!),
                    builder:
                        (context, AsyncSnapshot<List<SimpleCredit>?> snapshot) {
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
                                  padding: EdgeInsets.only(
                                      right: Paddings.low.value),
                                  child: PosterCard.fromCredit(
                                    simpleCredit: actor,
                                  ),
                                ): const SizedBox.shrink();
                              },
                            ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
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
}

class _ImageAndOverviewRow extends StatelessWidget {
  const _ImageAndOverviewRow({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPosterNetworkImage(
          path: movie.posterPath,
          height: ImageSizes.detailsHeight.value,
          width: ImageSizes.detailsWidth.value,
        ),
        SizedBox(width: context.sized.lowValue),
        Expanded(
          child: Column(
            children: [
              Text(
                movie.overview ?? " ",
                style: Theme.of(context).textTheme.bodyMedium,
                // maxLines: 5,
                // overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TitleAndInfoColumn extends StatelessWidget {
  const _TitleAndInfoColumn({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title!,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Row(
          children: [
            GreyInfoLabel(data: movie.status),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Paddings.lowlow.value,
                  horizontal: Paddings.medium.value),
              child: GreyInfoLabel(data: movie.releaseDate?.extractYear()),
            ),
          ],
        ),
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
