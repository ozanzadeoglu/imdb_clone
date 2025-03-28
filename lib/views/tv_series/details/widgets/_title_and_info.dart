part of '../tv_series_details_view.dart';

class _TitleAndInfo extends StatelessWidget {
  const _TitleAndInfo({
    required this.tvSeries,
  });

  final TVSeries tvSeries;

  String? editDateIfNotNull(String? date) {
    if (date != null) {
      if (date.isNotEmpty) {
        String editedDate = date;
        return editedDate.extractYear();
      }
    }
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tvSeries.name!,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Row(
          children: [
            const GreyInfoLabel(data: StringConstants.tvSeries),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Paddings.medium.value),
              child: GreyInfoLabel(data: tvSeries.firstAirDate?.extractYear()),
            ),
            GreyInfoLabel(data: tvSeries.lastAirDate?.extractYear()),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Paddings.lowlow.value,
                  horizontal: Paddings.medium.value),
              child: GreyInfoLabel(data: tvSeries.status),
            ),
          ],
        ),
      ],
    );
  }
}