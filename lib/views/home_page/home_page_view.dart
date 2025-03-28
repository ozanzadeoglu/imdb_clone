import 'package:imdb_app/components/common/custom_backdrop_network_image.dart';
import 'package:imdb_app/components/common/custom_poster_network_image.dart';
import 'package:imdb_app/components/common/loading_widget.dart';
import 'package:imdb_app/components/common/poster_card_wrapper.dart';
import 'package:imdb_app/constants/string_constants.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/simple_media.dart';
import 'package:imdb_app/models/poster_card_media.dart';
import 'package:imdb_app/network_manager/people_service.dart';
import 'package:imdb_app/network_manager/trending_service.dart';
import 'package:imdb_app/utility/navigation_utils.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter/material.dart';

part "widgets/_media_showcase_slider.dart";

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late final Future<List<SimpleMedia>?> trendingAsTopMedia;
  late final Future<List<PosterCardMedia>?> trendingAsPosterCard;
  late final Future<List<PosterCardMedia>?> popularPeople;

  @override
  void initState() {
    super.initState();
    trendingAsTopMedia = _fetchTrending();
    trendingAsPosterCard = _fetchTrendingDay();
    popularPeople = _fetchPopularPeople();
  }

  Future<List<SimpleMedia>?> _fetchTrending() async {
    TrendingService service = TrendingService();
    return await service.fetchTrendingMedia(timeWindow: "week");
  }

  Future<List<PosterCardMedia>?> _fetchTrendingDay() async {
    TrendingService service = TrendingService();
    return await service.fetchTrendingAsPosterCard(timeWindow: "day");
  }

  Future<List<PosterCardMedia>?> _fetchPopularPeople() async {
    IPeopleService service = PeopleService();
    return await service.fetchPopularPeople();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              mq.orientation == Orientation.portrait
                  ? SizedBox(
                      height: context.sized.width * 2 / 3 +
                          context.sized.height * 0.05,
                      child: _topSlidingView(),
                    )
                  : SizedBox.shrink(),

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
      ),
    );
  }

  FutureBuilder<List<SimpleMedia>?> _topSlidingView() {
    return FutureBuilder<List<SimpleMedia>?>(
      future: trendingAsTopMedia,
      builder:
          (BuildContext context, AsyncSnapshot<List<SimpleMedia>?> snapshot) {
        if (snapshot.hasData) {
          return PageView.builder(
            allowImplicitScrolling: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final media = snapshot
                  .data![index % snapshot.data!.length]; //infinite scroll logic
              return _MediaShowcaseSlider(
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

  FutureBuilder<List<PosterCardMedia>?> trendingTodayPoster() {
    return FutureBuilder(
      future: trendingAsPosterCard,
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
      future: popularPeople,
      builder: (context, AsyncSnapshot<List<PosterCardMedia>?> snapshot) {
        if (snapshot.hasData) {
          final popularList = snapshot.data;
          return PosterCardWrapper<PosterCardMedia>(
            title: StringConstants.popularPeople,
            list: popularList,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}