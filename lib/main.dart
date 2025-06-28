import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imdb_app/components/custom_navigation_bar.dart';
import 'package:imdb_app/constants/box_names.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';
import 'package:imdb_app/models/bookmark/bookmarked_movie.dart';
import 'package:imdb_app/models/bookmark/bookmarked_people.dart';
import 'package:imdb_app/models/bookmark/bookmarked_tv_series.dart';
import 'package:imdb_app/models/genre.dart';
import 'package:imdb_app/models/movie.dart';
import 'package:imdb_app/models/people.dart';
import 'package:imdb_app/models/tv_series.dart';
import 'package:imdb_app/views/bookmark/bookmark_view.dart';
import 'package:imdb_app/views/bookmark/bookmark_view_controller.dart';
import 'package:imdb_app/views/movie/movie_details_controller.dart';
import 'package:imdb_app/views/people/people_details_controller.dart';
import 'package:imdb_app/views/search/search_view_controller.dart';
import 'package:imdb_app/views/tv_series/details/tv_series_details_controller.dart';
import 'package:imdb_app/views/tv_series/seasons/tv_series_seasons_controller.dart';
import 'package:imdb_app/enums/paddings.dart';
import 'package:imdb_app/models/search/simple_list_tile_media.dart';
import 'package:imdb_app/views/home_page/home_page_view.dart';
import 'package:imdb_app/views/movie/movie_details_view.dart';
import 'package:imdb_app/views/people/people_details_view.dart';
import 'package:imdb_app/views/search/search_view.dart';
import 'package:imdb_app/views/tv_series/details/tv_series_details_view.dart';
import 'package:imdb_app/views/tv_series/seasons/tv_series_seasons_view.dart';
import 'package:provider/provider.dart';

import 'models/search/simple_list_tile_media_history.dart';

void main() async {
  await Hive.initFlutter();

  //Search history adapters
  Hive.registerAdapter(SimpleListTileMediaHistoryAdapter());
  Hive.registerAdapter(SimpleListTileMediaAdapter());

  //Media related adapters
  Hive.registerAdapter(MediaTypesAdapter());
  Hive.registerAdapter(GenreAdapter());
  Hive.registerAdapter(MovieAdapter());
  Hive.registerAdapter(TVSeriesAdapter());
  Hive.registerAdapter(PeopleAdapter());
  
  //Bookmark adapters
  Hive.registerAdapter(BookmarkedMovieAdapter());
  Hive.registerAdapter(BookmarkedTvSeriesAdapter());
  Hive.registerAdapter(BookmarkedPeopleAdapter());

  await Hive.openBox<BookmarkEntity>(BoxNames.bookmarkBox);
  await Hive.openBox<SimpleListTileMediaHistory>(BoxNames.resentSearchBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: CustomNavigationBar(
              // Determine the current index based on the route location
              currentRoute: state.uri.toString(),
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            name: "home",
            builder: (context, state) => const HomePageView(),
          ),
          GoRoute(
              path: '/search',
              name: "search",
              builder: (context, state) {
                return ChangeNotifierProvider(
                    create: (_) => SearchViewController(),
                    child: const SearchView());
              }),
          GoRoute(
              path: '/bookmark',
              name: "bookmark",
              builder: (context, state) {
                return ChangeNotifierProvider(
                  create: (_) => BookmarkViewController(),
                  child: const BookmarkView(),
                );
              }
              // builder: (context, state) => const BookmarkView(),
              ),
          GoRoute(
            path: '/movie/:id',
            name: 'movieDetails',
            builder: (context, state) {
              final movieID = int.parse(state.pathParameters['id']!);
              final movieTitle = state.uri.queryParameters['title'];
              return ChangeNotifierProvider(
                    create: (_) => MovieDetailsController(
                      movieID: movieID, 
                      movieTitle: movieTitle!
                    ),
                    child: const MovieDetailsView(),
                  );
            },
          ),
          GoRoute(
            path: '/person/:id',
            name: 'personDetails',
            builder: (context, state) {
              final peopleID = int.parse(state.pathParameters['id']!);
              final peopleName = state.uri.queryParameters['name'];
              return ChangeNotifierProvider(
                    create: (_) => PeopleDetailsController(
                      peopleID: peopleID,
                      peopleName: peopleName ?? "",
                    ),
                    child: const PeopleDetailsView(),
                  );
            },
          ),
          GoRoute(
            path: '/tv/:id',
            name: 'tvDetails',
            builder: (context, state) {
              final tvSeriesID = int.parse(state.pathParameters['id']!);
              final tvSeriesName = state.uri.queryParameters['name'];
              return ChangeNotifierProvider(
                    create: (_) => TvSeriesDetailsController(
                      tvSeriesID: tvSeriesID,
                      tvSeriesName: tvSeriesName ?? "",
                    ),
                    child: const TvSeriesDetailsView(),
                  );
            },
            routes: [
              GoRoute(
                path: 'seasons',
                name: 'seasons',
                builder: (context, state) {
                  final tvSeriesID =
                      int.parse(state.uri.queryParameters['id']!);
                  final numberOfSeasons =
                      int.parse(state.uri.queryParameters['seasons']!);
                  return ChangeNotifierProvider(
                    create: (_) => TvSeriesSeasonsController(
                      tvSeriesID: tvSeriesID,
                      numberOfSeasons: numberOfSeasons,
                    ),
                    child: const TvSeriesSeasonsView(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Movie Hive',
      theme: ThemeData.dark().copyWith(
        splashColor: Colors.transparent,
        listTileTheme: Theme.of(context).listTileTheme.copyWith(
            titleTextStyle: const TextStyle(color: ColorConstants.white),
            subtitleTextStyle:
                const TextStyle(color: ColorConstants.kettleman)),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              color: ColorConstants.offBlack,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Paddings.low.value),
                ),
                borderSide: const BorderSide(color: ColorConstants.millionGrey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Paddings.low.value),
                ),
                borderSide: const BorderSide(color: ColorConstants.millionGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Paddings.low.value),
                ),
                borderSide: const BorderSide(color: ColorConstants.millionGrey),
              ),
            ),
      ),
      //home: HomePageView(),
    );
  }
}
