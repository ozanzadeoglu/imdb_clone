part of '../search_view.dart';

class _RecentSearchesView extends StatelessWidget {
  _RecentSearchesView();

  final navigation = NavigationUtils();

  @override
  Widget build(BuildContext context) {
    final itemList =
        context.select<SearchViewController, List<SimpleListTileMedia>?>(
            (v) => v.researchesList);
    final vm = context.read<SearchViewController>();

    final double listTileHeight = 120;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: Paddings.low.value),
              child: Text(StringConstants.recentSearches,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            Padding(
              padding: EdgeInsets.only(right: Paddings.low.value),
              child: TextButton(
                onPressed: vm.clearRecentSearches,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                child: Text(StringConstants.clear,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: ColorConstants.iconYellow)),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: itemList!.length,
            itemBuilder: (context, index) {
              final item = itemList[index];
              return SizedBox(
                height: listTileHeight,
                child: _SearchTile(
                  item: item,
                  onTap: () {
                    vm.addToHistory(item);
                    navigation.launchDependingOnMediaType(
                      mediaType: item.mediaType,
                      mediaID: item.id,
                      mediaTitle: item.name,
                      context: context,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}