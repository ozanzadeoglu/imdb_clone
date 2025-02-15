import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imdb_app/constants/color_constants.dart';

//used in only poster images. Will be used in most of the components in the home screen.
class CustomPosterNetworkImage extends StatelessWidget {
  final String? path;
  final double? height;
  final double? width;

  const CustomPosterNetworkImage(
      {super.key, required this.path, this.height, this.width});

  //if path is null
  bool isPathNull() {
    //inconsistent api, thats why there's two conditions.
    if (path == null || path == "") {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //if path is null, return a asset image that tells there's no image,
    //if it's not null return the image.network
    return isPathNull()
        ? Image.asset(
            "assets/no_image.png",
            width: width,
            height: height,
            fit: BoxFit.fill,
          )
        : CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: "https://image.tmdb.org/t/p/original/$path",
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.iconYellow,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          );
  }
}
