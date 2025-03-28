part of "../home_page_view.dart";

class _MediaShowcaseSlider extends StatelessWidget {
  final SimpleMedia simpleMedia;

  const _MediaShowcaseSlider({
    required this.simpleMedia,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (simpleMedia.id != null &&
            (simpleMedia.title ?? simpleMedia.name) != null) {
          NavigationUtils().launchDependingOnMediaType(
            context: context,
            mediaType: simpleMedia.mediaType,
            mediaID: simpleMedia.id,
            mediaTitle: simpleMedia.name ?? simpleMedia.title,
          );
        }
      },
      child: Stack(
        children: [
          Positioned(
            width: context.sized.width,
            //api backdrop image resolution is 1.7, height is calculated
            //depending on width.
            height: context.sized.width / 1.7777,
            bottom: context.sized.height * 0.1,
            child: CustomBackdropNetworkImage(path: simpleMedia.backdropPath),
          ),
          Positioned(
            height: context.sized.height * 0.2,
            width: context.sized.width * 0.9,
            bottom: 0,
            left: context.sized.width * 0.1,
            child: Row(
              children: [
                CustomPosterNetworkImage(path: simpleMedia.posterPath),
                Expanded(
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                    simpleMedia.title ?? simpleMedia.name ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                subtitle: Text(simpleMedia.overview ?? "",
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}