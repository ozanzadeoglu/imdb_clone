import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imdb_app/components/common/confirm_dialog.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/components/common/custom_poster_network_image.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/extensions/better_display.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';
import 'package:imdb_app/models/bookmark/bookmarked_movie.dart';
import 'package:imdb_app/models/bookmark/bookmarked_people.dart';
import 'package:imdb_app/models/bookmark/bookmarked_tv_series.dart';
import 'package:imdb_app/models/movie.dart';
import 'package:imdb_app/models/people.dart';
import 'package:imdb_app/models/tv_series.dart';
import 'package:imdb_app/utility/navigation_utils.dart';
import 'package:imdb_app/views/bookmark/bookmark_view_controller.dart';
import 'package:provider/provider.dart';

part "widgets/_bookmark_poster.dart";

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  final nav = NavigationUtils();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<BookmarkViewController>();
    final bookmarks =
        context.select<BookmarkViewController, List<BookmarkEntity>>(
            (vm) => vm.bookmarks);
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.bookmark),
        actions: [
          TextButton(onPressed: vm.addTestBookmark, child: Text("add")),
          TextButton(onPressed: vm.removeTestBookmark, child: Text("remove")),
          TextButton(onPressed: vm.clearBookmarks, child: Text("clear"))
        ],
      ),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final item = bookmarks[index];
          return Center(
            child: SizedBox(
              height: 160,
              child: _BookmarkCard.fromType(
                item: item,
                onBookmarkIconTap: () => showRemoveBookmarkDialog(item),
                onCardTap: () => nav.launchDependingOnMediaType(
                  context: context,
                  mediaType: item.mediaType.value,
                  mediaID: item.originalMediaId,
                  mediaTitle: item.title,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showRemoveBookmarkDialog(BookmarkEntity item) async {
    final vm = context.read<BookmarkViewController>();
    final shouldRemove = await showDialog(
      context: context,
      builder: (context) => const ConfirmDialog(
        title: null,
        message: StringConstants.bookmarkConfirmDialogMessage,
        confirmColor: ColorConstants.vermillonCinnabar,
      ),
    );
    if (shouldRemove == true) {
      vm.removeBookmark(item);
    }
  }
}
