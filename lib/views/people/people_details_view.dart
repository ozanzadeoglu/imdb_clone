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
import 'package:imdb_app/views/people/people_details_controller.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

part 'widgets/_image_and_info.dart';
part 'widgets/_expandable_biography.dart';

class PeopleDetailsView extends StatefulWidget {
  const PeopleDetailsView({super.key});

  @override
  State<PeopleDetailsView> createState() => _PeopleDetailsViewState();
}

class _PeopleDetailsViewState extends State<PeopleDetailsView> {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<PeopleDetailsController>();
    final isLoading =
        context.select<PeopleDetailsController, bool>((vm) => vm.isLoading);
    return Scaffold(
      appBar: AppBar(title: Text(vm.peopleName), centerTitle: false),
      body: (!isLoading && vm.people != null)
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(Paddings.medium.value),
                    child: _ImageAndInfoRow(people: vm.people!),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Paddings.medium.value),
                    child:
                        _ExpandableBiography(biography: vm.people!.biography),
                  ),
                  PosterCardWrapper<PosterCardMedia>(
                    title: StringConstants.peopleDetailsKnownFor,
                    future: vm.knownForList,
                  ),
                ],
              ),
            )
          : const Center(child: LoadingWidget()),
    );
  }
}
