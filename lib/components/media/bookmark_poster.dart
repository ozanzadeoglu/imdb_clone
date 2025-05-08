import 'package:flutter/material.dart';
import 'package:imdb_app/components/common/custom_poster_network_image.dart';

class BookmarkPoster extends StatelessWidget {
  final String? path;
  final double? height;
  final double? width;
  final bool? isBookmarked;

  const BookmarkPoster(
      {super.key,
      required this.path,
      this.height,
      this.width,
      required this.isBookmarked});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Positioned(
            child: CustomPosterNetworkImage(
              path: path,
              height: height,
              width: width,
            ),
          ),
          ClickableBookmark(isBookmarked: isBookmarked),
        ],
      ),
    );
  }
}

class ClickableBookmark extends StatefulWidget {
  final bool? isBookmarked;
  const ClickableBookmark({super.key, this.isBookmarked = false});

  @override
  State<ClickableBookmark> createState() => _ClickableBookmarkState();
}

class _ClickableBookmarkState extends State<ClickableBookmark> {
  bool? _isBookmarked;

  @override
  void initState() {
    _isBookmarked = widget.isBookmarked ?? false;
    super.initState();
  }
  final String bookmarkPath = "assets/bookmark.png";

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            width: 52,
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                bookmarkPath,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            right: 2,
            bottom: 14,
            child: Center(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _isBookmarked = !_isBookmarked!;
                  });
                },
                isSelected: _isBookmarked,
                selectedIcon: const Icon(Icons.add, color: Colors.blue),
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
