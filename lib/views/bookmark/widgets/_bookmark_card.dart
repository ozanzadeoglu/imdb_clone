part of "../bookmark_view.dart";

class _BookmarkCard<T extends BookmarkEntity> extends StatelessWidget {
  final String? imagePath;
  final VoidCallback? onBookmarkIconTap;
  final VoidCallback? onCardTap;
  final VoidCallback? onAddNoteTap;
  final String? note;

  final Movie? movie;
  final TVSeries? tvSeries;
  final People? people;

  const _BookmarkCard({
    super.key,
    required this.imagePath,
    required this.onBookmarkIconTap,
    required this.onCardTap,
    required this.onAddNoteTap,
    this.note,
    this.movie,
    this.tvSeries,
    this.people,
  });

  factory _BookmarkCard.fromType(
      {required item,
      required onBookmarkIconTap,
      required onCardTap,
      required onAddNoteTap}) {
    if (item is BookmarkedMovie) {
      return _BookmarkCard.fromBookmarkedMovie(
        onBookmarkIconTap: onBookmarkIconTap,
        onCardTap: onCardTap,
        onAddNoteTap: onAddNoteTap,
        item: item,
      );
    } else if (item is BookmarkedTvSeries) {
      return _BookmarkCard.fromBookmarkedTvSeries(
        onBookmarkIconTap: onBookmarkIconTap,
        onCardTap: onCardTap,
        onAddNoteTap: onAddNoteTap,
        item: item,
      );
    } else {
      return _BookmarkCard.fromBookmarkedPeople(
        onBookmarkIconTap: onBookmarkIconTap,
        onCardTap: onCardTap,
        onAddNoteTap: onAddNoteTap,
        item: item,
      );
    }
  }

  _BookmarkCard.fromBookmarkedMovie(
      {super.key,
      required this.onBookmarkIconTap,
      required this.onCardTap,
      required this.onAddNoteTap,
      required BookmarkedMovie item})
      : imagePath = item.movie.posterPath,
        note = item.note,
        movie = item.movie,
        tvSeries = null,
        people = null;

  _BookmarkCard.fromBookmarkedTvSeries(
      {super.key,
      required this.onBookmarkIconTap,
      required this.onCardTap,
      required this.onAddNoteTap,
      required BookmarkedTvSeries item})
      : imagePath = item.tvSeries.posterPath,
        note = item.note,
        movie = null,
        tvSeries = item.tvSeries,
        people = null;

  _BookmarkCard.fromBookmarkedPeople(
      {super.key,
      required this.onBookmarkIconTap,
      required this.onCardTap,
      required this.onAddNoteTap,
      required BookmarkedPeople item})
      : imagePath = item.person.imagePath,
        note = item.note,
        movie = null,
        tvSeries = null,
        people = item.person;

  @override
  Widget build(BuildContext context) {
    const double posterWidth = 95.0;

    return InkWell(
      onTap: onCardTap,
      child: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: ColorConstants.kettleman))),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Paddings.medium.value, vertical: Paddings.low.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: posterWidth,
                    child: AspectRatio(
                        aspectRatio: 1 / 1.5,
                        child: _BookmarkPoster(
                            imagePath: imagePath, onTap: onBookmarkIconTap)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: Paddings.low.value),
                      child: _BookmarkCardDetails(
                        movie: movie,
                        tvSeries: tvSeries,
                        people: people,
                      ),
                    ),
                  ),
                  _BookmarkActionsMenuButton(
                    onRemove: onBookmarkIconTap,
                    onAddNote: onAddNoteTap,
                    note: note,
                  ),
                ],
              ),
              if (note != null && note!.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    note!,
                    textAlign: TextAlign.left,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

