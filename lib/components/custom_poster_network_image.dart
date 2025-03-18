import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//used in only poster images. Will be used in most of the components in the home screen.
class CustomPosterNetworkImage extends StatelessWidget {
  final String? path;
  final double? height;
  final double? width;

  const CustomPosterNetworkImage(
      {super.key, required this.path, this.height, this.width});

  ///Returns true if path is null or empty.
  bool isPathNull() {
    //inconsistent api, thats why there's two conditions.
    if (path == null || path == "") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final String networkImagePath = "https://image.tmdb.org/t/p/original/$path";
    final String noImagePath = "assets/no_image.png";
    final String placeholderPath = "assets/poster_placeholder.png";


    //if path is null, return a asset image that tells there's no image,
    //if it's not null return the image.network
    return isPathNull()
        ? Image.asset(
            noImagePath,
            width: width,
            height: height,
            fit: BoxFit.fill,
          )
        : CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: networkImagePath,
            fit: BoxFit.cover,
            fadeInDuration: Duration(microseconds: 0),
            fadeOutDuration:Duration(microseconds: 0),
            placeholder: (context, url) => Image.asset(
              placeholderPath,
              fit: BoxFit.fill,
            ),
            errorWidget: (context, url, error) => Image.asset(
            noImagePath,
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
          );
  }
}
