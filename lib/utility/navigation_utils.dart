import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/enums/media_types.dart';

class NavigationUtils {
  void launchDependingOnMediaType({
    required BuildContext context,
    required final String? mediaType,
    final String? mediaTitle,
    final int? mediaID,
  }) {
    if (mediaType == MediaTypes.person.value &&
        mediaTitle != null &&
        mediaID != null) {
      context.pushNamed(
        "personDetails",
        queryParameters: {'name': mediaTitle},
        pathParameters: {'id': mediaID.toString()},
      );
    } else if (mediaType == MediaTypes.movie.value &&
        mediaID != null &&
        mediaTitle != null) {
      context.pushNamed("movieDetails", queryParameters: {'title': mediaTitle}, pathParameters: {'id': mediaID.toString()},);
    } else if (mediaType == MediaTypes.tv.value &&
        mediaID != null &&
        mediaTitle != null) {
      context.pushNamed("tvDetails", queryParameters: {'name': mediaTitle}, pathParameters: {'id': mediaID.toString()},);
    } else {
      //dont do anything
    }
  }
}
