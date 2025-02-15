import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imdb_app/constants/color_constants.dart';

class CustomBackdropNetworkImage extends StatelessWidget {
  final String? path;
  const CustomBackdropNetworkImage({super.key, required this.path});

  //check if path is null
  bool isPathNull() {
    //inconsistent api, thats why there's two conditions.
    if (path == null || path == "") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //if path is null show no image available asset.
    //this one takes its width and length from parent widget
    //different than poster image.
    return isPathNull()
        ? Image.asset(
            "assets/no_image.png",
            fit: BoxFit.fill,
          )
        //const SizedBox.shrink()
        : CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/original/$path",
               placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.iconYellow,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
    // Image.network(
    //   "https://image.tmdb.org/t/p/original/$path",
    // );
  }
}
