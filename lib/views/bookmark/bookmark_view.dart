import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/components/common/custom_poster_network_image.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/extensions/better_display.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';
import 'package:imdb_app/models/bookmark/bookmarked_movie.dart';
import 'package:imdb_app/models/bookmark/bookmarked_tv_series.dart';
import 'package:imdb_app/models/movie.dart';
import 'package:imdb_app/models/people.dart';
import 'package:imdb_app/models/tv_series.dart';
import 'package:imdb_app/utility/navigation_utils.dart';
import 'package:imdb_app/views/bookmark/bookmark_view_controller.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

part "widgets/_bookmark_poster.dart";

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  final vm = BookmarkViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(StringConstants.bookmark),
          actions: [
            TextButton(onPressed: vm.addTestBookmark, child: Text("add")),
            TextButton(onPressed: vm.removeTestBookmark, child: Text("remove")),
            TextButton(onPressed: vm.clearBookmarks, child: Text("clear"))
          ],
        ),
        body: ValueListenableBuilder<Box<BookmarkEntity>>(
            valueListenable: vm.bookmarkBox.listenable(),
            builder: (context, box, child) {
             var bookmarks = vm.fetchBookmarks();
              return ListView.builder(
                itemCount: bookmarks?.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: SizedBox(
                      height: 120,
                      child: _BookmarkCard.fromType(
                          item: bookmarks?[index], onTap: null),
                    ),
                  );
                },
              );
            })
        );
  }
}
