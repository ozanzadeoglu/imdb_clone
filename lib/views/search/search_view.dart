import 'package:flutter/material.dart';
import 'package:imdb_app/components/custom_list_tile.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/views/search/search_view_controller.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/simple_list_tile_media.dart';
import 'package:imdb_app/utility/navigation_utils.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final isFocused =
        context.select<SearchViewController, bool>((c) => c.isFocused);

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: ColorConstants.offBlack,
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 0,
          toolbarHeight: kToolbarHeight + 18,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 12),
            child: CustomSearchBar(),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child:
                    isFocused ? SearchResultsListView() : RecentSearchesView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    final controller = context.read<SearchViewController>();
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIconColor: ColorConstants.thamarBlack,
              prefixIcon: Icon(Icons.search),
            ),
            controller: controller.textController,
            focusNode: controller.textFieldFocusNode,
            keyboardType: TextInputType.name,
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: kToolbarHeight,
            child: TextButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
              onPressed: controller.clearTextFieldText,
              child: Text(StringConstants.cancel,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: ColorConstants.iconYellow)),
            ),
          ),
        ),
      ],
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  SearchResultsListView({super.key});

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
          child: CustomListTile(
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

class RecentSearchesView extends StatelessWidget {
  RecentSearchesView({super.key});

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
                child: CustomListTile(
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
