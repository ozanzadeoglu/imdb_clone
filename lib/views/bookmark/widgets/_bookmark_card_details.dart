part of '../bookmark_view.dart';

class _BookmarkCardDetails extends StatelessWidget {
  final Movie? movie;
  final TVSeries? tvSeries;
  final People? people;

  const _BookmarkCardDetails({
    this.movie,
    this.tvSeries,
    this.people,
  });

  @override
  Widget build(BuildContext context) {
    if (movie != null) {
      return _buildMovieDetails(context, movie!);
    }
    else if (tvSeries != null) {
      return _buildTvSeriesDetails(context, tvSeries!);
    }
    else if (people != null) {
      return _buildPeopleDetails(context, people!);
    }

    return const SizedBox.shrink();
  }

  Widget _buildMovieDetails(BuildContext context, Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          movie.title ?? "",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            Text(MediaTypes.movie.value.capitalizeFirstLetter()),
            if (movie.releaseDate != null && movie.releaseDate!.isNotEmpty)
              Text(", ${movie.releaseDate!.extractYear()}"),
          ],
        ),
        _BookmarkRating(rating: movie.voteAverage),
      ],
    );
  }

  Widget _buildTvSeriesDetails(BuildContext context, TVSeries tvSeries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tvSeries.name ?? "",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            const Text(StringConstants.tvSeries),
            if (tvSeries.firstAirDate != null &&
                tvSeries.firstAirDate!.isNotEmpty)
              Text(", ${tvSeries.firstAirDate!.extractYear()} "),
            Text("${tvSeries.numberOfEpisodes.toString()}eps"),
          ],
        ),
        _BookmarkRating(rating: tvSeries.voteAverage),
      ],
    );
  }

  Widget _buildPeopleDetails(BuildContext context, People people) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          people.name ?? "",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            Text("${MediaTypes.person.value.capitalizeFirstLetter()}, "),
            if (people.knownForDepartment != null)
              Text(people.knownForDepartment!),
          ],
        ),
      ],
    );
  }
}

class _BookmarkRating extends StatelessWidget {
  final double? rating;
  const _BookmarkRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return rating == null
        ? const SizedBox.shrink()
        : SizedBox(
            height: 24,
            child: Row(
              children: [
                const Icon(Icons.star, color: ColorConstants.iconYellow),
                Text(rating!.toStringAsFixed(1),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white)),
              ],
            ),
          );
  }
}