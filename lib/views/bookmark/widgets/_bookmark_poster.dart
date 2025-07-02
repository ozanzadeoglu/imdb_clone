part of "../bookmark_view.dart";

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