import 'package:flutter/material.dart';
import 'package:imdb_app/constants/color_constants.dart';

class GreyInfoLabel extends StatelessWidget {
  final String? data;
  const GreyInfoLabel({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? "",
      style: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(color: ColorConstants.kettleman),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
