import 'package:flutter/material.dart';
import 'package:imdb_app/components/custom_listview.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/enums/icon_sizes.dart';
import 'package:imdb_app/enums/paddings.dart';

class PosterCardWrapper extends StatelessWidget {
  final String title;
  final String? description;
  final CustomListView customListView;

  const PosterCardWrapper({
    super.key,
    required this.title,
    this.description,
    required this.customListView,
  });

  //List<String> buttonOptions = ["day", "week"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.thamarBlack,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Paddings.lowHigh.value, vertical: Paddings.low.value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: Paddings.low.value),
                  child: const _TitleIcon(),
                ),
                Text(title, style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: _DescriptionText(description: description),
            ),

            Padding(
                padding: EdgeInsets.symmetric(vertical: Paddings.low.value),
                child: customListView),
          ],
        ),
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  final String? description;

  const _DescriptionText({required this.description});

  @override
  Widget build(BuildContext context) {
    return description == null || description == ""
        ? const SizedBox.shrink()
        : Text(
            description!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: ColorConstants.millionGrey),
          );
  }
}

class _TitleIcon extends StatelessWidget {
  const _TitleIcon();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(3),
        bottom: Radius.circular(3),
      ),
      child: Container(
        height: IconSizes.medium.value,
        width: 6,
        color: ColorConstants.iconYellow,
      ),
    );
  }
}
