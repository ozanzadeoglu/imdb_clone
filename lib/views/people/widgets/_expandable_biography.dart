part of '../people_details_view.dart';

class _ExpandableBiography extends StatelessWidget {
  const _ExpandableBiography({
    required this.biography,
  });

  final String? biography;

  bool isBiographyEmpty() {
    if (biography == "" || biography == null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight =
        Theme.of(context).textTheme.titleLarge!.fontSize! + Paddings.low.value;

    return isBiographyEmpty()
        ? const SizedBox.shrink()
        : ExpandableNotifier(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: containerHeight,
                  decoration: BoxDecoration(
                    color: ColorConstants.offBlack,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Paddings.low.value),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: containerHeight / 2,
                        child: _BiographyTitleContainer(
                            containerHeight: containerHeight),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.offBlack,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(Paddings.low.value),
                    ),
                  ),
                  child: Expandable(
                    collapsed: _CollapsedBiography(biography: biography!),
                    expanded: _ExpandedBiography(biography: biography!),
                  ),
                ),
              ],
            ),
          );
  }
}

class _BiographyTitleContainer extends StatelessWidget {
  final double containerHeight;

  const _BiographyTitleContainer({required this.containerHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      decoration: const ShapeDecoration(
          color: ColorConstants.iconYellow, shape: StadiumBorder()),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.sized.width * 0.05,
          ),
          child: Text(StringConstants.peopleDetailsBiography,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class _CollapsedBiography extends StatelessWidget {
  final String biography;
  const _CollapsedBiography({required this.biography});

  @override
  Widget build(BuildContext context) {
    return ExpandableButton(
      theme: ExpandableThemeData(
        inkWellBorderRadius: BorderRadius.vertical(
          bottom: Radius.circular(Paddings.low.value),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            Paddings.low.value, 0, Paddings.low.value, Paddings.low.value),
        child: Column(
          children: [
            Text(biography, maxLines: 3, overflow: TextOverflow.ellipsis),
            const Align(
              alignment: Alignment.center,
              child: Icon(Icons.arrow_downward_sharp,
                  color: ColorConstants.iconYellow),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandedBiography extends StatelessWidget {
  final String biography;
  const _ExpandedBiography({required this.biography});

  @override
  Widget build(BuildContext context) {
    return ExpandableButton(
      theme: ExpandableThemeData(
        inkWellBorderRadius: BorderRadius.vertical(
          bottom: Radius.circular(Paddings.low.value),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            Paddings.low.value, 0, Paddings.low.value, Paddings.low.value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              biography,
            ),
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_upward_sharp,
                color: ColorConstants.iconYellow,
              ),
            )
          ],
        ),
      ),
    );
  }
}
