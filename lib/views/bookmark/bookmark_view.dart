import 'package:flutter/material.dart';
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

part "widgets/_bookmark_card.dart";
part "widgets/_filter_button.dart";
part 'widgets/_note_editor_dialog.dart';
part 'widgets/_bookmark_poster.dart';
part 'widgets/_bookmark_card_details.dart';
part 'widgets/_bookmark_actions_menu_button.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({super.key});

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  final nav = NavigationUtils();
  final double cardHeight = 160;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<BookmarkViewController>();
    final bookmarks =
        context.select<BookmarkViewController, List<BookmarkEntity>>(
            (vm) => vm.displayBookmarks);
    final MediaTypes? selectedType = context
        .select<BookmarkViewController, MediaTypes?>((vm) => vm.typeFilter);

    final DateSortOrder? dateFilter = context
        .select<BookmarkViewController, DateSortOrder?>((vm) => vm.dateFilter);

    //it's purely to rebuild view when a note is added to a [BookmarkEntity],
    //I'm not really satisfied with this workaround, should look into it later.  
    // ignore: unused_local_variable
    final bool reload = context
        .select<BookmarkViewController, bool>((vm) => vm.reload);


    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(StringConstants.bookmark,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(Paddings.medium.value),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              spacing: Paddings.medium.value,
              children: [
                _FilterButton(
                  buttonTitles: MediaTypes.values,
                  onPressed: vm.addTypeFilter,
                  onUnselect: vm.clearTypeFilter,
                  selectedFilter: selectedType,
                  unselectedLabel: StringConstants.type,
                ),
                _FilterButton(
                  buttonTitles: DateSortOrder.values,
                  onPressed: vm.addDateFilter,
                  onUnselect: vm.clearDateFilter,
                  selectedFilter: dateFilter,
                  unselectedLabel: StringConstants.dateAdded,
                ),
              ],
            ),
          ),
          const Divider(height: 2),
          Padding(
            padding: EdgeInsets.all(Paddings.medium.value),
            child: resultsTextWidget(
              bookmarks.length,
              vm.totalBookmarksLength,
              (dateFilter != null || selectedType != null),
            ),
          ),
          const Divider(height: 2),
          SizedBox(height: Paddings.low.value),
          Expanded(
            child: ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final item = bookmarks[index];
                return Center(
                  child: _BookmarkCard.fromType(
                    item: item,
                    onBookmarkIconTap: () => _showRemoveBookmarkDialog(item),
                    onCardTap: () => nav.launchDependingOnMediaType(
                      context: context,
                      mediaType: item.mediaType.value,
                      mediaID: item.originalMediaId,
                      mediaTitle: item.title,
                    ),
                    onAddNoteTap: () => _showNoteEditor(item),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Text resultsTextWidget(
      int filteredBookmarkLength, int totalBookmarkLength, bool isFiltered) {
    final result = filteredBookmarkLength == 1
        ? StringConstants.result
        : StringConstants.results;
    final fullText = isFiltered
        ? "$filteredBookmarkLength (${StringConstants.of} $totalBookmarkLength) $result"
        : "$totalBookmarkLength $result";

    return Text(fullText, style: Theme.of(context).textTheme.bodyLarge);
  }

  void _showRemoveBookmarkDialog(BookmarkEntity item) async {
    final vm = context.read<BookmarkViewController>();
    final shouldRemove = await showDialog(
      context: context,
      builder: (context) => const ConfirmDialog(
        title: null,
        message: StringConstants.bookmarkConfirmDialogMessage,
        confirmColor: ColorConstants.vermillonCinnabar,
        confirmLabel: StringConstants.remove,
      ),
    );
    if (shouldRemove == true) {
      vm.removeBookmark(item);
    }
  }
    void _showNoteEditor(BookmarkEntity item) {
    final vm = context.read<BookmarkViewController>();

    showDialog(
      context: context,
      builder: (context) {
        return _NoteEditorDialog(
          initialNote: item.note,
          onSave: (String newNote) {
            vm.updateBookmarkNote(item, newNote);
          },
        );
      },
    );
  }
}
