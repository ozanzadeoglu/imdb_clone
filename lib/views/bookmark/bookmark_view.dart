import 'package:flutter/material.dart';
import 'package:imdb_app/constants/string_constants.dart';

class BookmarkView extends StatelessWidget {
  const BookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.bookmark)),
    );
  }
}
