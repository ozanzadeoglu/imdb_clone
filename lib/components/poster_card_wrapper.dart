import 'package:flutter/material.dart';
import 'package:imdb_app/components/custom_listview.dart';
import 'package:imdb_app/components/poster_card.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/enums/icon_sizes.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/abstracts/base_poster_card.dart';

class PosterCardWrapper<T extends BasePosterCard> extends StatelessWidget {
  final String title;
  final String? description;
  final List<T>? list;

  const PosterCardWrapper({
    super.key,
    required this.title,
    this.description,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return list != null && list!.isNotEmpty ? SafeArea(
      top: false,
      child: Container(
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
                child: HorizontalPosterCardList<T>(list: list),
              ),
            ],
          ),
        ),
      ),
    ) : const SizedBox.shrink();
  }
}

class HorizontalPosterCardList<T extends BasePosterCard> extends StatelessWidget {
  const HorizontalPosterCardList({
    super.key,
    required this.list,
  });

  final List? list;

  @override
  Widget build(BuildContext context) {
    return (list != null && list!.isNotEmpty)
        ? CustomListView(
            prototype: PosterCard<T>.fromType(
              data: list![0],
            ),
            listView: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list?.length,
              itemBuilder: (context, index) {
                final data = list?[index];
                return data != null
                    ? Padding(
                        padding: EdgeInsets.only(right: Paddings.low.value),
                        child: PosterCard<T>.fromType(
                          data: data,
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          )
        : const SizedBox.shrink();
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
