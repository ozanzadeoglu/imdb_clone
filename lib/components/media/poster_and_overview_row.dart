import 'package:flutter/material.dart';
import 'package:imdb_app/components/media/bookmark_poster.dart';
import 'package:imdb_app/enums/image_sizes.dart';
import 'package:kartal/kartal.dart';

class PosterAndOverviewRow extends StatelessWidget {
  const PosterAndOverviewRow(
      {super.key, required this.posterPath, required this.overview});

  final String? posterPath;
  final String? overview;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookmarkPoster(
          path: posterPath,
          height: ImageSizes.detailsHeight.value,
          width: ImageSizes.detailsWidth.value,
          isBookmarked: null,
        ),
        SizedBox(width: context.sized.lowValue),
        Expanded(
          child: Text(
            overview ?? " ",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
