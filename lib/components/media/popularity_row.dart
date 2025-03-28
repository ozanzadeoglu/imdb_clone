import 'package:flutter/material.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/enums/icon_sizes.dart';

class PopularityRow extends StatelessWidget {
  final double popularity;
  final double voteAverage;
  final int voteCount;

  const PopularityRow({
    super.key,
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
