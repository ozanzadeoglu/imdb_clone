import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:imdb_app/constants/hive_adapters.dart';
import 'package:imdb_app/enums/media_types.dart';
import 'package:imdb_app/models/bookmark/bookmarked_movie.dart';
import 'package:imdb_app/models/bookmark/bookmarked_people.dart';
import 'package:imdb_app/models/bookmark/bookmarked_tv_series.dart';
import 'package:imdb_app/models/genre.dart';
import 'package:imdb_app/models/movie.dart';
import 'package:imdb_app/models/people.dart';
import 'package:imdb_app/models/bookmark/bookmark_entity.dart';
import 'package:imdb_app/models/tv_series.dart';

void main() {
  setUp(() async {
    Hive.init("testDatabase");

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
  });

  test("Test storing and fetching", () async {
    final boxName = 'testBookmark';

    final Box<BookmarkEntity> bookmarkBox =
        await Hive.openBox<BookmarkEntity>(boxName);

    final People testPerson = People(
      id: 111,
      name: "Test Person",
      knownForDepartment: null,
      birthday: null,
      deathDay: null,
      biography: null,
      imagePath: null,
      gender: null,
      placeOfBirth: null,
    );

    final Movie testMovie = Movie(
        popularity: 1,
        voteAverage: 1,
        voteCount: 1,
        id: 222,
        title: "Test Movie");

    final TVSeries testTvSeries = TVSeries(
        popularity: 1,
        voteAverage: 1,
        voteCount: 1,
        id: 333,
        name: "Test Tv-series");

    final date = DateTime.now();

    final testBookmarkedPeople =
        BookmarkedPeople(bookmarkedDate: date, person: testPerson);

    final testBookmarkedMovie =
        BookmarkedMovie(bookmarkedDate: date, movie: testMovie);

    final testBookmarkedTvSeries =
        BookmarkedTvSeries(bookmarkedDate: date, tvSeries: testTvSeries);

    bookmarkBox.put(testBookmarkedPeople.id, testBookmarkedPeople);
    bookmarkBox.put(testBookmarkedMovie.id, testBookmarkedMovie);
    bookmarkBox.put(testBookmarkedTvSeries.id, testBookmarkedTvSeries);

    var fetchedItems = bookmarkBox.values.toList();

    expect(fetchedItems.first.runtimeType, BookmarkedMovie);

    await bookmarkBox.clear();
    await bookmarkBox.deleteFromDisk();
    await Hive.close();
  });
}
