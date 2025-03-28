part of '../tv_series_details_view.dart';

class _EpisodeGuideRow extends StatelessWidget {
  const _EpisodeGuideRow({required this.tvSeries});

  final TVSeries tvSeries;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (tvSeries.numberOfSeasons != null && tvSeries.id != null) {
              context.pushNamed(
                "seasons",
                queryParameters: {
                  'id': tvSeries.id.toString(),
                  'seasons': tvSeries.numberOfSeasons.toString()
                },
                pathParameters: {'id': tvSeries.id.toString()},
              );
            }
          },
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Paddings.medium.value,
                vertical: Paddings.lowHigh.value,
              ),
              child: const Text(
                StringConstants.tvSeriesEpisodeGuide,
                style: TextStyle(color: ColorConstants.iconYellow),
              ),
            ),
          ),
        ),
        GreyInfoLabel(
            data:
                "${tvSeries.numberOfEpisodes.toString()} ${StringConstants.tvSeriesEpisodes}")
      ],
    );
  }
}