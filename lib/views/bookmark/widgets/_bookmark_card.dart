part of "../bookmark_view.dart";

class _BookmarkCard<T extends BookmarkEntity> extends StatelessWidget {
  final String? imagePath;
  final VoidCallback? onBookmarkIconTap;
  final VoidCallback? onCardTap;

  final Movie? movie;
  final TVSeries? tvSeries;
  final People? people;

  const _BookmarkCard({
    super.key,
    required this.imagePath,
    required this.onBookmarkIconTap,
    required this.onCardTap,
    this.movie,
    this.tvSeries,
    this.people,
  });

  factory _BookmarkCard.fromType(
      {required item, required onBookmarkIconTap, required onCardTap}) {
    if (item is BookmarkedMovie) {
      return _BookmarkCard.fromBookmarkedMovie(
        onBookmarkIconTap: onBookmarkIconTap,
        onCardTap: onCardTap,
        item: item,
      );
    } else if (item is BookmarkedTvSeries) {
      return _BookmarkCard.fromBookmarkedTvSeries(
        onBookmarkIconTap: onBookmarkIconTap,
        onCardTap: onCardTap,
        item: item,
      );
    } else {
      return _BookmarkCard.fromBookmarkedPeople(
        onBookmarkIconTap: onBookmarkIconTap,
        onCardTap: onCardTap,
        item: item,
      );
    }
  }

  _BookmarkCard.fromBookmarkedMovie(
      {super.key,
      required this.onBookmarkIconTap,
      required this.onCardTap,
      required BookmarkedMovie item})
      : imagePath = item.movie.posterPath,
        movie = item.movie,
        tvSeries = null,
        people = null;

  _BookmarkCard.fromBookmarkedTvSeries(
      {super.key,
      required this.onBookmarkIconTap,
      required this.onCardTap,
      required BookmarkedTvSeries item})
      : imagePath = item.tvSeries.posterPath,
        movie = null,
        tvSeries = item.tvSeries,
        people = null;

  _BookmarkCard.fromBookmarkedPeople(
      {super.key,
      required this.onBookmarkIconTap,
      required this.onCardTap,
      required BookmarkedPeople item})
      : imagePath = item.person.imagePath,
        movie = null,
        tvSeries = null,
        people = item.person;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: ColorConstants.kettleman))),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Paddings.medium.value, vertical: Paddings.low.value),
          child: Row(
            children: [
              AspectRatio(
                  aspectRatio: 1 / 1.5,
                  child: _BookmarkPoster(imagePath: imagePath, onTap: onBookmarkIconTap)),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: Paddings.low.value),
                  child: columnLayoutDependingMedia(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column columnLayoutDependingMedia(BuildContext context) {
    if (movie != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            movie!.title ?? "",
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
              movie!.releaseDate != null && movie!.releaseDate!.isNotEmpty
                  ? Text(", ${movie!.releaseDate!.extractYear()}")
                  : const SizedBox.shrink(),
            ],
          ),
          PosterCardRating(rating: movie!.voteAverage),
        ],
      );
    } else if (tvSeries != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tvSeries!.name ?? "",
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
              tvSeries!.firstAirDate != null &&
                      tvSeries!.firstAirDate!.isNotEmpty
                  ? Text(", ${tvSeries!.firstAirDate!.extractYear()} ")
                  : const SizedBox.shrink(),
              Text("${tvSeries!.numberOfEpisodes.toString()}eps")
            ],
          ),
          PosterCardRating(rating: tvSeries!.voteAverage),
        ],
      );
    } else if (people != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            people!.name ?? "",
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
              people!.knownForDepartment != null
                  ? Text(people!.knownForDepartment!)
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      );
    }
    return const Column(mainAxisSize: MainAxisSize.min);
  }
}

class _BookmarkPoster extends StatelessWidget {
  final String? imagePath;
  final VoidCallback? onTap;

  const _BookmarkPoster({required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: CustomPosterNetworkImage(
            path: imagePath,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: InkWell(onTap: onTap, child: const _BookmarkIcon()),
        ),
      ],
    );
  }
}

class _BookmarkIcon extends StatelessWidget {
  const _BookmarkIcon();

  final String bookmarkImagePath = "assets/bookmark.png";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          width: 40,
          child: Opacity(
            opacity: 1,
            child: Image.asset(
              bookmarkImagePath,
              color: ColorConstants.iconYellow,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        const Positioned(
            right: 8,
            bottom: 16,
            child: Icon(Icons.check, color: Colors.black)),
      ],
    );
  }
}

class PosterCardRating extends StatelessWidget {
  final double? rating;
  const PosterCardRating({super.key, required this.rating});

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
