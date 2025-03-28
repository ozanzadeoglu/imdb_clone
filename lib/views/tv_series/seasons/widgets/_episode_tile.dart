part of '../tv_series_seasons_view.dart';

class _EpisodeTile extends StatelessWidget {
  final SimpleTvSeriesEpisode episode;
  final int episodeNum;

  const _EpisodeTile({required this.episode, required this.episodeNum});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Paddings.low.value),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: AspectRatio(
                aspectRatio: 1 / 1.5,
                child:
                    CustomPosterNetworkImage(path: episode.episodeImagePath)),
          ),
          const Spacer(),
          Expanded(
            flex: 18,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("${episodeNum + 1}. ${episode.episodeName}",
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: Paddings.low.value),

                Row(
                  spacing: Paddings.low.value,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: ColorConstants.iconYellow,
                        ),
                        Text((episode.episodeVoteAverage ?? 0.0)
                            .toStringAsFixed(1)),
                      ],
                    ),

                    Text(episode.airDate.toString()),

                    episode.episodeRuntime != null
                        ? Text("${episode.episodeRuntime.toString()}m")
                        : const SizedBox.shrink(),
                  ],
                ),
                SizedBox(height: Paddings.low.value),
                Text(
                  episode.episodeOverview,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}