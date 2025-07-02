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
                      child: columnLayoutDependingMedia(context),
                    ),
                  ),
                  _ItemActionsMenu(
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

  Column columnLayoutDependingMedia(BuildContext context) {
    if (movie != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            movie!.title ?? "",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(MediaTypes.movie.value.capitalizeFirstLetter()),
              movie!.releaseDate != null && movie!.releaseDate!.isNotEmpty
                  ? Text(", ${movie!.releaseDate!.extractYear()}")
                  : const SizedBox.shrink(),
            ],
          ),
          PosterCardRating(rating: movie!.voteAverage),
        ],
      );
    } else if (tvSeries != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tvSeries!.name ?? "",
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
              tvSeries!.firstAirDate != null &&
                      tvSeries!.firstAirDate!.isNotEmpty
                  ? Text(", ${tvSeries!.firstAirDate!.extractYear()} ")
                  : const SizedBox.shrink(),
              Text("${tvSeries!.numberOfEpisodes.toString()}eps")
            ],
          ),
          PosterCardRating(rating: tvSeries!.voteAverage),
        ],
      );
    } else if (people != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            people!.name ?? "",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text("${MediaTypes.person.value.capitalizeFirstLetter()}, "),
              people!.knownForDepartment != null
                  ? Text(people!.knownForDepartment!)
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      );
    }
    return const Column(mainAxisSize: MainAxisSize.min);
  }
}

class _ItemActionsMenu extends StatefulWidget {
  final VoidCallback? onRemove;
  final VoidCallback? onAddNote;
  final String? note;

  const _ItemActionsMenu({
    required this.onRemove,
    required this.onAddNote,
    required this.note
  });

  @override
  State<_ItemActionsMenu> createState() => _ItemActionsMenuState();
}

class _ItemActionsMenuState extends State<_ItemActionsMenu> {
  late final MenuController _menuController;

  @override
  void initState() {
    _menuController = MenuController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  final hasNote = (widget.note != null && widget.note!.isNotEmpty); 

    return MenuAnchor(
      controller: _menuController,
      builder: (context, controller, child) {
        return IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: controller.isOpen ? controller.close : controller.open,
        );
      },
      menuChildren: [
        MenuItemButton(
          onPressed: widget.onAddNote,
          child: Text(
            hasNote ? StringConstants.editNote : StringConstants.addNote ,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        MenuItemButton(
          onPressed: widget.onRemove,
          child: const Text(
            StringConstants.remove,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _BookmarkPoster extends StatelessWidget {
  final String? imagePath;
  final VoidCallback? onTap;

  const _BookmarkPoster({required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: CustomPosterNetworkImage(
            path: imagePath,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: InkWell(onTap: onTap, child: const _BookmarkIcon()),
        ),
      ],
    );
  }
}

class _BookmarkIcon extends StatelessWidget {
  const _BookmarkIcon();

  final String bookmarkImagePath = "assets/bookmark.png";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          width: 40,
          child: Opacity(
            opacity: 1,
            child: Image.asset(
              bookmarkImagePath,
              color: ColorConstants.iconYellow,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        const Positioned(
            right: 8,
            bottom: 16,
            child: Icon(Icons.check, color: Colors.black)),
      ],
    );
  }
}

class PosterCardRating extends StatelessWidget {
  final double? rating;
  const PosterCardRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return rating == null
        ? const SizedBox.shrink()
        : SizedBox(
            height: 24,
            child: Row(
              children: [
                const Icon(Icons.star, color: ColorConstants.iconYellow),
                Text(rating!.toStringAsFixed(1),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white)),
              ],
            ),
          );
  }
}

class NoteEditorDialog extends StatefulWidget {
  final String? initialNote;
  final Function(String) onSave;

  const NoteEditorDialog({
    super.key,
    this.initialNote,
    required this.onSave,
  });

  @override
  State<NoteEditorDialog> createState() => _NoteEditorDialogState();
}

class _NoteEditorDialogState extends State<NoteEditorDialog> {
  late final TextEditingController _textController;
  late final ScrollController _scrollController;
  final int _characterLimit = 10000;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialNote);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSave() {
    widget.onSave(_textController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const BeveledRectangleBorder(),
      insetPadding: EdgeInsets.all(Paddings.lowHigh.value),
      actionsAlignment: MainAxisAlignment.start,
      backgroundColor: ColorConstants.offBlack,
      title: const Text(StringConstants.note),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Scrollbar(
                controller: _scrollController,
                thickness: 4,
                thumbVisibility: true,
                child: TextField(
                  scrollController: _scrollController,
                  controller: _textController,
                  autofocus: true,
                  maxLength: _characterLimit,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: ColorConstants.offBlack,
                    border: OutlineInputBorder(),
                    counterText: "",
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: ListenableBuilder(
                  listenable: _textController,
                  builder: (context, child) {
                    return Text(
                      "${_textController.text.length} ${StringConstants.of} $_characterLimit ${StringConstants.characters}",
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            shape: const BeveledRectangleBorder(),
          ),
          onPressed: _handleSave,
          child: const Text(StringConstants.save),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: const BeveledRectangleBorder(),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(StringConstants.cancel,
              style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
