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

class PeopleDetailsView extends StatelessWidget {
  final int peopleID;
  final String peopleName;
  PeopleDetailsView(
      {super.key, required this.peopleName, required this.peopleID});

  final IPeopleService _service = PeopleService();

  Future<People?> fetchPersonDetails(int peopleID) async {
    final response =
        await _service.fetchPeopleDetailsWithID(peopleID: peopleID);
    if (response != null) {
      return response;
    }
    return null;
  }

  Future<List<PosterCardMedia>?> fetchKnownList() async {
    final response = await _service.fetchPeopleKnownFor(peopleName: peopleName);

    if (response != null) {
      return response;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(peopleName), centerTitle: false),
      body: FutureBuilder(
        future: fetchPersonDetails(peopleID),
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
                    child: ExpanableBiographyContainer(
                        biography: people.biography),
                  ),
                  knownForPosterCardListView(),
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

  FutureBuilder<List<PosterCardMedia>?> knownForPosterCardListView() {
    return FutureBuilder(
      future: fetchKnownList(),
      builder: (context, AsyncSnapshot<List<PosterCardMedia>?> snapshot) {
        if (snapshot.hasData) {
          final knownForList = snapshot.data;
          return PosterCardWrapper<PosterCardMedia>(
            title: StringConstants.peopleDetailsKnownFor,
            list: knownForList,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class ExpanableBiographyContainer extends StatelessWidget {
  const ExpanableBiographyContainer({
    super.key,
    required this.biography,
  });

  final String? biography;

  bool isBiographyEmpty() {
    if (biography == "" || biography == null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight =
        Theme.of(context).textTheme.titleLarge!.fontSize! + Paddings.low.value;

    return isBiographyEmpty()
        ? const SizedBox.shrink()
        : ExpandableNotifier(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: containerHeight,
                  decoration: BoxDecoration(
                    color: ColorConstants.offBlack,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(context.sized.height * 0.02),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: containerHeight / 2,
                        child: descriptionContainer(context, containerHeight),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.offBlack,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(context.sized.height * 0.02),
                    ),
                  ),
                  child: Expandable(
                    collapsed: collapsedBiography(context),
                    expanded: expandedBiography(context),
                  ),
                ),
              ],
            ),
          );
  }

  Container descriptionContainer(BuildContext context, double containerHeight) {
    return Container(
      height: containerHeight,
      decoration: const ShapeDecoration(
          color: ColorConstants.iconYellow, shape: StadiumBorder()),
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.sized.width * 0.05,
          ),
          child: Text(StringConstants.peopleDetailsBiography,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  ExpandableButton collapsedBiography(BuildContext context) {
    return ExpandableButton(
      theme: ExpandableThemeData(
        inkWellBorderRadius: BorderRadius.vertical(
          bottom: Radius.circular(context.sized.height * 0.02),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            Paddings.low.value, 0, Paddings.low.value, Paddings.low.value),
        child: Column(
          children: [
            Text(biography!, maxLines: 3, overflow: TextOverflow.ellipsis),
            const Align(
              alignment: Alignment.center,
              child: Icon(Icons.arrow_downward_sharp,
                  color: ColorConstants.iconYellow),
            ),
          ],
        ),
      ),
    );
  }

  ExpandableButton expandedBiography(BuildContext context) {
    return ExpandableButton(
      theme: ExpandableThemeData(
        inkWellBorderRadius: BorderRadius.vertical(
          bottom: Radius.circular(context.sized.height * 0.02),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            Paddings.low.value, 0, Paddings.low.value, Paddings.low.value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              biography!,
            ),
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_upward_sharp,
                color: ColorConstants.iconYellow,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ImageAndInfoRow extends StatelessWidget {
  const _ImageAndInfoRow({
    required this.people,
  });

  final People people;

  bool isNullOrEmpty(String? string) {
    if (string == "" || string == null) {
      return true;
    }
    return false;
  }

  Widget singleInfoRow(
      {required String field,
      required String? value,
      required BuildContext context}) {
    return isNullOrEmpty(value)
        ? const SizedBox.shrink()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Text("$field: ",
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  value!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPosterNetworkImage(
          path: people.imagePath,
          height: ImageSizes.detailsHeight.value,
          width: ImageSizes.detailsWidth.value,
        ),
        SizedBox(width: context.sized.lowValue),
        Expanded(
          child: Column(
            spacing: Paddings.lowlow.value,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                people.name ?? StringConstants.unknownName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              singleInfoRow(
                  field: StringConstants.peopleDetailsKnownFor,
                  value: people.knownForDepartment,
                  context: context),
              singleInfoRow(
                  field: StringConstants.peopleDetailsGender,
                  value: people.gender,
                  context: context),
              singleInfoRow(
                  field: StringConstants.peopleDetailsBirthday,
                  value: people.birthday,
                  context: context),
              singleInfoRow(
                  field: StringConstants.peopleDetailsDeathday,
                  value: people.deathDay,
                  context: context),
              singleInfoRow(
                  field: StringConstants.peopleDetailsPlaceOfBirth,
                  value: people.placeOfBirth,
                  context: context),
            ],
          ),
        ),
      ],
    );
  }
}
