part of "../bookmark_view.dart";

class _BookmarkCard<T extends BookmarkEntity> extends StatelessWidget {
  final String? imagePath;
  final VoidCallback? onTap;

  final Movie? movie;
  final TVSeries? tvSeries;
  final People? people;

  const _BookmarkCard({
    super.key,
    required this.imagePath,
    required this.onTap,
    this.movie,
    this.tvSeries,
    this.people,
  });

  factory _BookmarkCard.fromType({required item, required onTap}) {
    if (item is BookmarkedMovie) {
      return _BookmarkCard.fromBookmarkedMovie(onTap: onTap, item: item);
    }
    // else if (item is BookmarkedTvSeries){
    //   return _BookmarkCard.fromBookmarkedMovie(onTap: onTap, item: item);
    // }
    else {
      return _BookmarkCard.fromBookmarkedMovie(onTap: onTap, item: item);
    }
  }

  _BookmarkCard.fromBookmarkedMovie(
      {super.key, required this.onTap, required BookmarkedMovie item})
      : imagePath = item.movie.posterPath,
        movie = item.movie,
        tvSeries = null,
        people = null;

  //   PosterCard.fromCredit({super.key, required SimpleCredit simpleCredit})
  //     : id = simpleCredit.id,
  //       info = simpleCredit.characterName,
  //       imagePath = simpleCredit.profilePath,
  //       title = simpleCredit.actorName,
  //       mediaType = MediaTypes.person.value,
  //       rating = null;

  // PosterCard.fromPosterCardMedia({super.key, required PosterCardMedia media})
  //     : id = media.id,
  //       info = media.mediaType,
  //       imagePath = media.posterPath,
  //       title = media.title,
  //       mediaType = media.mediaType,
  //       rating = media.voteAverage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                child: CustomPosterNetworkImage(path: imagePath),
              ),
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
              tvSeries!.firstAirDate != null && tvSeries!.firstAirDate!.isNotEmpty
                  ? Text(", ${tvSeries!.firstAirDate!.extractYear()}")
                  : const SizedBox.shrink(),
            ],
          ),
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
    return const Column();
  }

// class _BookmarkCard<T extends BookmarkEntity> extends StatelessWidget {
//   final String? imagePath;
//   final String? title;
//   final String? info;
//   final int? id;
//   final MediaTypes mediaType;
//   final double? rating;
//   final VoidCallback? onTap;

//   const _BookmarkCard({
//     super.key,
//     required this.imagePath,
//     required this.title,
//     required this.info,
//     required this.id,
//     required this.mediaType,
//     this.rating,
//     required this.onTap,
//   });

//   factory _BookmarkCard.fromType({required item, required onTap}) {
//     if (item is BookmarkedMovie) {
//       return _BookmarkCard.fromBookmarkedMovie(onTap: onTap, item: item);
//     }
//     // else if (item is BookmarkedTvSeries){
//     //   return _BookmarkCard.fromBookmarkedMovie(onTap: onTap, item: item);
//     // }
//     else {
//       return _BookmarkCard.fromBookmarkedMovie(onTap: onTap, item: item);
//     }
//   }

//    _BookmarkCard.fromBookmarkedMovie(
//       {super.key, required this.onTap, required BookmarkedMovie item})
//       : id = item.movie.id,
//         imagePath = item.movie.posterPath,
//         info = item.movie.overview,
//         mediaType = MediaTypes.movie,
//         rating = item.movie.voteAverage,
//         title = item.movie.title;

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () => NavigationUtils().launchDependingOnMediaType(
  //       context: context,
  //       mediaType: mediaType,
  //       mediaID: id,
  //       mediaTitle: title,
  //     ),
  //     child: SizedBox(
  //       width: 140,
  //       child: Container(
  //         decoration: wrapperContainerDecoration(context),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             _BookmarkPoster(
  //               imagePath: imagePath,
  //               onTap: onTap,
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(Paddings.low.value),
  //               child: _PosterCardInfoColumn(
  //                 title: title,
  //                 info: info,
  //                 rating: rating,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // BoxDecoration wrapperContainerDecoration(BuildContext context) {
  //   return BoxDecoration(
  //     color: ColorConstants.offBlack,
  //     borderRadius: BorderRadius.circular(context.sized.normalValue),
  //   );
  // }
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
          width: 52,
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
            right: 15,
            bottom: 25,
            child: Icon(Icons.check, color: Colors.black)),
      ],
    );
  }
}

class _PosterCardInfoColumn extends StatelessWidget {
  final String? title;
  final String? info;
  final double? rating;

  const _PosterCardInfoColumn({
    required this.title,
    required this.info,
    required this.rating,
  });

  //info will stay as it is if it's created
  //with a people detail but if it's a part
  //of mediaType, the info will be change from
  //"tv" to "Tv-Series" and "movie" to "Movie"
  String? changeInfoIfNeeded(String? info) {
    if (info == MediaTypes.movie.value) {
      return StringConstants.movie;
    } else if (info == MediaTypes.tv.value) {
      return StringConstants.tvSeries;
    } else if (info == MediaTypes.person.value) {
      return StringConstants.people;
    } else {
      return info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double posterCardTitleBoxHeight = 48;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PosterCardRating(rating: rating), //24
        SizedBox(height: Paddings.lowlow.value),
        SizedBox(
            height: posterCardTitleBoxHeight,
            child: PosterCardTitleBox(title: title)),
        const SizedBox(height: 12),
        Text(changeInfoIfNeeded(info) ?? " ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

//poster card's title will be created here.
//text wrapped by fixed height sizedbox so ui
//will not depend on title length. e.g 1 line, 2 lines
class PosterCardTitleBox extends StatelessWidget {
  final String? title;
  const PosterCardTitleBox({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(title ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white));
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
