import 'package:flutter/material.dart';
import 'package:imdb_app/components/common/custom_poster_network_image.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/extensions/better_display.dart';
import 'package:imdb_app/views/search/search_view_controller.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/simple_list_tile_media.dart';
import 'package:imdb_app/utility/navigation_utils.dart';
import 'package:provider/provider.dart';

part 'widgets/_search_tile.dart';
part 'widgets/_custom_search_bar.dart';
part 'widgets/_recent_searches_view.dart';
part 'widgets/_search_results_view.dart';

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
          title: const Padding(
            padding: EdgeInsets.fromLTRB(8, 6, 8, 12),
            child: _CustomSearchBar(),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child:
                    isFocused ? _SearchResultsView() : _RecentSearchesView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
