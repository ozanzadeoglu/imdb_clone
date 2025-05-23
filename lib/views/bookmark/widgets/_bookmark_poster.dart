part of "../bookmark_view.dart";

class PosterCard<T extends BookmarkEntity> extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final String? info;
  final int? id;
  final String? mediaType;
  final double? rating;
  final VoidCallback? onTap;
  final bool? isBookmarked;

  const PosterCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.info,
    required this.id,
    required this.mediaType,
    this.rating,
    required this.onTap,
    required this.isBookmarked,
  });

  // factory PosterCard.fromType({required data}) {
  //   if (T == BookmarkedMovie) {

  //   }
  //   else if (T == BookmarkedTvSeries){

  //   }
  //   else {

  //   }
  // }

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
    return GestureDetector(
      onTap: () => NavigationUtils().launchDependingOnMediaType(
        context: context,
        mediaType: mediaType,
        mediaID: id,
        mediaTitle: title,
      ),
      child: SizedBox(
        width: 140,
        child: Container(
          decoration: wrapperContainerDecoration(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _BookmarkPoster(
                imagePath: imagePath,
                isBookmarked: isBookmarked ?? true,
                onTap: onTap,
              ),
              Padding(
                padding: EdgeInsets.all(Paddings.low.value),
                child: _PosterCardInfoColumn(
                  title: title,
                  info: info,
                  rating: rating,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration wrapperContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: ColorConstants.offBlack,
      borderRadius: BorderRadius.circular(context.sized.normalValue),
    );
  }
}

class _BookmarkPoster extends StatelessWidget {
  final String? imagePath;
  final bool isBookmarked;
  final VoidCallback? onTap;

  const _BookmarkPoster(
      {required this.imagePath,
      required this.isBookmarked,
      required this.onTap});

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
          child: InkWell(
              onTap: onTap,
              child: _ClickableBookmark(isBookmarked: isBookmarked)),
        ),
      ],
    );
  }
}

class _ClickableBookmark extends StatelessWidget {
  final bool isBookmarked;
  const _ClickableBookmark({required this.isBookmarked});


  final String bookmarkPath = "assets/bookmark.png";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          width: 52,
          child: Opacity(
            opacity: isBookmarked ? 1 : 0.6, //0.4,
            child: Image.asset(
              bookmarkPath,
              color: isBookmarked ? ColorConstants.iconYellow : null,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          right: 15,
          bottom: 25,
          child: isBookmarked
              ? const Icon(Icons.check, color: Colors.black)
              : const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }
}

// Positioned(
        //   right: 2,
        //   bottom: 14,
        //   child: Container(
        //     color: Colors.red,
        //     child: _isBookmarked
        //         ? const Icon(Icons.check, color: Colors.black)
        //         : const Icon(Icons.add, color: Colors.white),
        //   ),
        // ),

// IconButton(
//               onPressed: () {
//                 setState(() {
//                   _isBookmarked = !_isBookmarked;
//                 });
//               },
//               isSelected: _isBookmarked,
//               selectedIcon: const Icon(Icons.check, color: Colors.black),
//               icon: const Icon(Icons.add, color: Colors.white),
//             ),

// class _PosterCardImage extends StatelessWidget {
//   final String? imagePath;
//   const _PosterCardImage({required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.vertical(
//           top: Radius.circular(context.sized.normalValue)),
//       child: CustomPosterNetworkImage(
//         path: imagePath,
//         height: 210,
//         width: 140,
//       ),
//     );
//   }
// }

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
