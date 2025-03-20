import 'package:imdb_app/components/custom_backdrop_network_image.dart';
import 'package:imdb_app/components/custom_poster_network_image.dart';
import 'package:imdb_app/components/loading_widget.dart';
import 'package:imdb_app/components/poster_card_wrapper.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/simple_media.dart';
import 'package:imdb_app/models/poster_card_media.dart';
import 'package:imdb_app/network_manager/people_service.dart';
import 'package:imdb_app/network_manager/trending_service.dart';
import 'package:imdb_app/utility/navigation_utils.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  Future<List<SimpleMedia>?> fetchTrending() async {
    TrendingService service = TrendingService();
    return await service.fetchTrendingMedia(timeWindow: "week");
  }

  Future<List<PosterCardMedia>?> fetchTrendingWeek() async {
    TrendingService service = TrendingService();
    return await service.fetchTrendingAsPosterCard(timeWindow: "day");
  }

  Future<List<PosterCardMedia>?> fetchPopularPeople() async {
    IPeopleService service = PeopleService();
    return await service.fetchPopularPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                height:
                    context.sized.width * 2 / 3 + context.sized.height * 0.05,
                child: _topSlidingView(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Paddings.lowHigh.value),
              child: trendingTodayPoster(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Paddings.lowHigh.value),
              child: popularPeopleView(),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<PosterCardMedia>?> trendingTodayPoster() {
    return FutureBuilder(
      future: fetchTrendingWeek(),
      builder: (context, AsyncSnapshot<List<PosterCardMedia>?> snapshot) {
        if (snapshot.hasData) {
          final trendingList = snapshot.data;
          return PosterCardWrapper<PosterCardMedia>(
            title: StringConstants.trendingToday,
            list: trendingList, 
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  FutureBuilder<List<PosterCardMedia>?> popularPeopleView() {
    return FutureBuilder(
      future: fetchPopularPeople(),
      builder: (context, AsyncSnapshot<List<PosterCardMedia>?> snapshot) {
        if (snapshot.hasData) {
          final popularList = snapshot.data;
          return PosterCardWrapper<PosterCardMedia>(
            title: StringConstants.popularPeople,
            list:  popularList,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  FutureBuilder<List<SimpleMedia>?> _topSlidingView() {
    return FutureBuilder<List<SimpleMedia>?>(
      future: fetchTrending(),
      builder:
          (BuildContext context, AsyncSnapshot<List<SimpleMedia>?> snapshot) {
        if (snapshot.hasData) {
          return PageView.builder(
            allowImplicitScrolling: true,
            scrollDirection: Axis.horizontal,
            //physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final media = snapshot
                  .data![index % snapshot.data!.length]; //infinite scroll logic
              return _CustomOnboardStack(
                simpleMedia: media,
              );
            },
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}

class _CustomOnboardStack extends StatelessWidget {
  final SimpleMedia simpleMedia;

  const _CustomOnboardStack({
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
