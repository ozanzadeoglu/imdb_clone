import 'package:flutter/material.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/genre.dart';

class SlideableGenre extends StatefulWidget {
  final List<Genre> genreList;

  const SlideableGenre({super.key, required this.genreList});

  @override
  State<SlideableGenre> createState() => _SlideableGenreState();
}

class _SlideableGenreState extends State<SlideableGenre> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      itemCount: widget.genreList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final item = widget.genreList[index];
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _GenreContainer(id: item.id!, name: item.name!),
        );
      },
    );
  }
}

class _GenreContainer extends StatelessWidget {
  final String name;
  final int id;
  const _GenreContainer({required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Paddings.low.value),
          color: ColorConstants.offBlack),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Paddings.low.value, vertical: Paddings.lowlow.value),
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorConstants.white,
                ),
          ),
        ),
      ),
    );
  }
}
