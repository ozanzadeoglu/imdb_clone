part of '../people_details_view.dart';

class _ImageAndInfoRow extends StatelessWidget {
  const _ImageAndInfoRow({
    required this.people,
  });

  final People people;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookmarkPoster(
          path: people.imagePath,
          height: ImageSizes.detailsHeight.value,
          width: ImageSizes.detailsWidth.value,
          isBookmarked: null,
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
              _SingleInfoRow(
                  field: StringConstants.peopleDetailsKnownFor,
                  value: people.knownForDepartment,
                  ),
              _SingleInfoRow(
                  field: StringConstants.peopleDetailsGender,
                  value: people.gender,
                  ),
              _SingleInfoRow(
                  field: StringConstants.peopleDetailsBirthday,
                  value: people.birthday,
                  ),
              _SingleInfoRow(
                  field: StringConstants.peopleDetailsDeathday,
                  value: people.deathDay,
                  ),
              _SingleInfoRow(
                  field: StringConstants.peopleDetailsPlaceOfBirth,
                  value: people.placeOfBirth,
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SingleInfoRow extends StatelessWidget {
  final String field;
  final String? value;

  const _SingleInfoRow({
    required this.field,
    required this.value,
  });

  bool isNullOrEmpty(String? string) {
    if (string == "" || string == null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
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
}
