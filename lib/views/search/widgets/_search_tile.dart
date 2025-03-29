part of '../search_view.dart';

class _SearchTile extends StatelessWidget {
  final SimpleListTileMedia item;
  final VoidCallback? onTap;
  const _SearchTile({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: ColorConstants.kettleman))),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Paddings.medium.value, vertical: Paddings.low.value),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1 / 1.5,
                child: CustomPosterNetworkImage(path: item.posterPath),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: Paddings.low.value),
                  child: columnLayoutDependingMedia(item, context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
    Column columnLayoutDependingMedia(
      SimpleListTileMedia item, BuildContext context) {
    if (item.mediaType == MediaTypes.movie.value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.name,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(item.mediaType.capitalizeFirstLetter()),
              item.releaseDate != null && item.releaseDate != ""
                  ? Text(", ${item.releaseDate!.extractYear()}")
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      );
    } else if (item.mediaType == MediaTypes.tv.value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.name,
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
              item.releaseDate != null && item.releaseDate != ""
                  ? Text(", ${item.releaseDate!.extractYear()}")
                  : const SizedBox.shrink(),
            ],
          ),
          item.mostKnownMedia != null
              ? Text(item.mostKnownMedia!.capitalizeFirstLetter())
              : const SizedBox.shrink()
        ],
      );
    } else if (item.mediaType == MediaTypes.person.value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.name,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text("${item.mediaType.capitalizeFirstLetter()}, "),
              item.knownForDepartment != null
                  ? Text(item.knownForDepartment!)
                  : const SizedBox.shrink(),
            ],
          ),
          item.mostKnownMedia != null
              ? Text(item.mostKnownMedia!)
              : const SizedBox.shrink()
        ],
      );
    }
    return const Column();
  }
}
