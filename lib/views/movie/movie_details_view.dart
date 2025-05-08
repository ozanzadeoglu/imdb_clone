import 'package:flutter/material.dart';
import 'package:imdb_app/components/common/custom_backdrop_network_image.dart';
import 'package:imdb_app/components/common/loading_widget.dart';
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
import 'package:imdb_app/services/movie_service.dart';
import 'package:kartal/kartal.dart';

part 'widgets/_title_and_info.dart';

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
  late final Future<Movie?> movie;
  late final Future<List<SimpleCredit>?> movieCredits;

  @override
  void initState() {
    super.initState();
    movie = fetchMovieDetails();
    movieCredits = fetchCredits();
  }

  Future<Movie?> fetchMovieDetails() async {
    final response =
        await _service.fetchMovieDetailsWithID(movieID: widget.movieID);
    if (response != null) {
      return response;
    }
    return null;
  }

  Future<List<SimpleCredit>?> fetchCredits() async {
    final response = await _service.fetchCreditsWithID(movieID: widget.movieID);
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
        future: movie,
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
                    child: _TitleAndInfo(movie: movie!),
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
                              path: movie.backdropPath),
                        )
                      : const SizedBox.shrink(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.low.value),
                    child: PosterAndOverviewRow(
                      overview: movie.overview,
                      posterPath: movie.posterPath,
                    ),
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
                    child: const Divider(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Paddings.medium.value,
                        vertical: Paddings.lowlow.value),
                    child: PopularityRow(
                        popularity: movie.popularity,
                        voteAverage: movie.voteAverage,
                        voteCount: movie.voteCount),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Paddings.low.value),
                    child: const Divider(),
                  ),
                  PosterCardWrapper<SimpleCredit>(
                    title: StringConstants.cast,
                    future: movieCredits,
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
