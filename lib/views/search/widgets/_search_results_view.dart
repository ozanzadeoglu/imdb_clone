part of '../search_view.dart';

class _SearchResultsView extends StatelessWidget {
  _SearchResultsView();

  final navigation = NavigationUtils();

  @override
  Widget build(BuildContext context) {
    final itemList =
        context.select<SearchViewController, List<SimpleListTileMedia>?>(
            (v) => v.listTileMediaList);
    final vm = context.read<SearchViewController>();

    final double listTileHeight = 120;

    return ListView.builder(
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
    );
  }
}