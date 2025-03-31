import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomBackdropNetworkImage extends StatelessWidget {
  final String? path;
  const CustomBackdropNetworkImage({super.key, required this.path});

  //check if path is null
  bool _isPathNull() {
    //inconsistent api, thats why there's two conditions.
    if (path == null || path == "") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final String networkImagePath = "https://image.tmdb.org/t/p/original/$path";
    final String placeholderPath = "assets/placeholder.png";

    //if path is null show no image available asset.
    //this one takes its width and length from parent widget
    //different than poster image.
    return _isPathNull()
        ? const SizedBox.shrink()
        // Image.asset(
        //   noImagePath,
        //   fit: BoxFit.fill,
        // )
        : CachedNetworkImage(
            fadeInDuration: const Duration(microseconds: 0),
            fadeOutDuration: const Duration(microseconds: 0),
            imageUrl: networkImagePath,
            placeholder: (context, url) => Image.asset(
              //parents have constraints, so height and width is determined
              //by parent's constraints. This logic is needed because on Tv Series
              //and movie views, parent is a constrained bo. When placeholder is shown
              //to user, due to image's initial height and width, it's smaller than the network image.
              //which causes the widget to enlarge when it swaps from placeholder to network
              //image.
              height: double.infinity,
              width: double.infinity,
              placeholderPath,
              fit: BoxFit.fill,
            ),
            errorWidget: (context, url, error) => const SizedBox.shrink(),
          );
  }
}
