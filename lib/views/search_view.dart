import 'package:flutter/material.dart';
import 'package:imdb_app/components/search_list_tile.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/controllers/search_view_controller.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/simple_list_tile_media.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});


  @override
  Widget build(BuildContext context) {
    final isFocused =
        context.select<SearchViewController, bool>((c) => c.isFocused);

    return Scaffold(
      body: Column(
        children: [
          SafeArea(child: CustomSearchBar()),
          Expanded(
            child: isFocused ? SearchResultsListView() :RecentSearchesView(),
          ),
        ],
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
    return Container(
      color: ColorConstants.offBlack,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.all(Paddings.medium.value),
              child: TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIconColor: ColorConstants.thamarBlack,
                  prefixIcon: Icon(Icons.search),),
                controller: controller.textController,
                focusNode: controller.textFieldFocusNode,
                keyboardType: TextInputType.name,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: TextButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                onPressed: controller.clearTextFieldText,
                child: Text("Cancel",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: ColorConstants.iconYellow)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  const SearchResultsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemList =
        context.select<SearchViewController, List<SimpleListTileMedia>?>(
            (v) => v.listTileMediaList);
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: itemList!.length,
      itemBuilder: (context, index) {
        final item = itemList[index];
        return SizedBox(
          height: context.sized.height * 0.13,
          child: SearchListTile(item: item),
        );
      },
    );
  }
}

class RecentSearchesView extends StatelessWidget {
  const RecentSearchesView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemList =
        context.select<SearchViewController, List<Map<String, Object>>?>(
            (v) => v.researchesList);
    final vm = context.read<SearchViewController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: Paddings.low.value),
              child: Text("Recent Searches",
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
                child: Text("Clear",
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
                height: context.sized.height * 0.13,
                child: SearchListTile(item: item['data'] as SimpleListTileMedia),
              );
            },
          ),
        ),
      ],
    );
  }
}
