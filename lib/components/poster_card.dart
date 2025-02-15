import 'package:flutter/material.dart';
import 'package:imdb_app/components/custom_poster_network_image.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/enums/image_sizes.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/enums/other_sizes.dart';
import 'package:imdb_app/models/simple_postercard_media.dart';
import 'package:imdb_app/utility/navigation_utils.dart';
import 'package:kartal/kartal.dart';

import '../models/simple_credit.dart';

class PosterCard extends StatelessWidget {
  final String? imagePath;
  final String? title;
  final String? info;
  final int? id;
  final String? mediaType;
  final double? rating;

  const PosterCard(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.info,
      required this.id,
      required this.mediaType,
      this.rating});

  PosterCard.fromCredit({super.key, required SimpleCredit simpleCredit})
      : id = simpleCredit.id,
        info = simpleCredit.characterName,
        imagePath = simpleCredit.profilePath,
        title = simpleCredit.actorName,
        mediaType = MediaTypes.person.value,
        rating = null;

  PosterCard.fromSimplePosterCardMedia(
      {super.key, required SimplePosterCardMedia media})
      : id = media.id,
        info = media.mediaType,
        imagePath = media.posterPath,
        title = media.title,
        mediaType = media.mediaType,
        rating = media.voteAverage;

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
        //looked into imdb from chrome devtools, in phone views
        //width was 0.4 of the screen width and height of the image was
        // 3/2 of the width.
        width: context.sized.width * ImageSizes.responsiveWidthMultiplier.value,
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstants.offBlack,
            borderRadius: BorderRadius.circular(context.sized.normalValue),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PosterCardImage(imagePath: imagePath),
              Padding(
                padding: EdgeInsets.all(context.sized.lowValue),
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
}

class _PosterCardImage extends StatelessWidget {
  final String? imagePath;
  const _PosterCardImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.sized.normalValue)),
      child: SizedBox(
          height: (context.sized.width *
                  ImageSizes.responsiveWidthMultiplier.value) *
              (3 / 2),
          child: CustomPosterNetworkImage(path: imagePath)),
    );
  }
}

//in devtools this components was a little bit weird. It took height
//from its childeren but the text was wrapped in a box with 2.5rem height.
//I'll look into textTheme's bodylarge's fon size and create a sizedbox
//according to it. Column will take its height from childeren.
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PosterCardRating(rating: rating),
        PosterCardTitleBox(
          title: title,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(changeInfoIfNeeded(info) ?? " ",
            maxLines: 1, overflow: TextOverflow.ellipsis),
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
    return SizedBox(
      height: OtherSizes.posterCardTitleHeight.value,
      child: Text(title ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white)),
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
        : Row(
            children: [
              const Icon(Icons.star, color: ColorConstants.iconYellow),
              Text(rating!.toStringAsFixed(1),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white)),
            ],
          );
  }
}
