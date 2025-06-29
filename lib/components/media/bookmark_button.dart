import 'package:flutter/material.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/enums/paddings.dart';

class BookmarkButton extends StatelessWidget {
  final bool isBookmarked;
  final VoidCallback? onTap;
  const BookmarkButton({super.key, required this.isBookmarked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: isBookmarked ? const BookmarkButtonRemove() : const BookmarkButtonAdd(),
      ),
    );
  }
}

class BookmarkButtonRemove extends StatelessWidget {
  const BookmarkButtonRemove({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(Paddings.low.value),
          border: Border.all(
            width: 1,
            color: ColorConstants.kettleman,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.check,
              size: 36,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            const SizedBox(width: 4),
            Text(
              StringConstants.removeFromBookmarks,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}


class BookmarkButtonAdd extends StatelessWidget {
  const BookmarkButtonAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.only(left: 8),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: ColorConstants.iconYellow,
          borderRadius: BorderRadius.circular(Paddings.low.value),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.add, size: 36, color: Colors.black),
            const SizedBox(width: 4),
            Text(
              StringConstants.addToBookmarks,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}


