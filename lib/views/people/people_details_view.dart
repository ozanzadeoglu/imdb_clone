import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:imdb_app/components/common/custom_poster_network_image.dart';
import 'package:imdb_app/components/common/loading_widget.dart';
import 'package:imdb_app/components/common/poster_card_wrapper.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/enums/image_sizes.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/people.dart';
import 'package:imdb_app/models/poster_card_media.dart';
import 'package:imdb_app/network_manager/people_service.dart';
import 'package:kartal/kartal.dart';

part 'widgets/_image_and_info.dart';
part 'widgets/_expandable_biography.dart';

class PeopleDetailsView extends StatefulWidget {
  final int peopleID;
  final String peopleName;
  const PeopleDetailsView(
      {super.key, required this.peopleName, required this.peopleID});

  @override
  State<PeopleDetailsView> createState() => _PeopleDetailsViewState();
}

class _PeopleDetailsViewState extends State<PeopleDetailsView> {
  final IPeopleService _service = PeopleService();
  late final Future<People?> people;
  late final Future<List<PosterCardMedia>?> knownForList;

  @override
  initState(){
    super.initState();
    people = fetchPersonDetails();
    knownForList = fetchKnownList();
  }

  Future<People?> fetchPersonDetails() async {
    final response =
        await _service.fetchPeopleDetailsWithID(peopleID: widget.peopleID);
    if (response != null) {
      return response;
    }
    return null;
  }

  Future<List<PosterCardMedia>?> fetchKnownList() async {
    final response = await _service.fetchPeopleKnownFor(peopleName: widget.peopleName);

    if (response != null) {
      return response;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.peopleName), centerTitle: false),
      body: FutureBuilder(
        future: people,
        builder: (context, AsyncSnapshot<People?> snapshot) {
          if (snapshot.hasData) {
            final people = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(Paddings.medium.value),
                    child: _ImageAndInfoRow(people: people),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Paddings.medium.value),
                    child: _ExpandableBiography(
                        biography: people.biography),
                  ),
                  PosterCardWrapper<PosterCardMedia>(
                    title: StringConstants.peopleDetailsKnownFor,
                    future: knownForList,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: LoadingWidget());
          }
        },
      ),
    );
  }
}