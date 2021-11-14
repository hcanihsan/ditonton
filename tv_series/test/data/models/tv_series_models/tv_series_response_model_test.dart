import 'dart:convert';
import 'package:tv_series/data/models/tv_series_models/tv_series_model.dart';
import 'package:tv_series/data/models/tv_series_models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../json_reader.dart';

void main() {
  // ignore: prefer_const_constructors
  final tTVSeriesModel = TVSeriesModel(
      backdropPath: '/oC9SgtJTDCEpWnTBtVGoAvjl5hb.jpg',
      genreIds: const [10767],
      id: 1991,
      name: 'Rachael Ray',
      originCountry: const ['US'],
      originalLanguage: 'en',
      originalName: 'Rachael Ray',
      overview:
          'Rachael Ray, also known as The Rachael Ray Show, is an American talk show starring Rachael Ray that debuted in syndication in the United States and Canada on September 18, 2006. It is filmed at Chelsea Television Studios in New York City. The show\'s 8th season premiered on September 9, 2013, and became the last Harpo show in syndication to switch to HD with a revamped studio. In January 2012, CBS Television Distribution announced a two-year renewal for the show, taking it through the 2013–14 season.',
      popularity: 3147.117,
      posterPath: '/dsAJhCLYX1fiNRoiiJqR6Up4aJ.jpg',
      voteAverage: 5.7,
      voteCount: 30);

  final tTVSeriesResponseModel =
      TVSeriesResponse(tvSeriesList: <TVSeriesModel>[tTVSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_now_playing.json'));
      // act
      final result = TVSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/oC9SgtJTDCEpWnTBtVGoAvjl5hb.jpg",
            "genre_ids": [10767],
            "id": 1991,
            "name": "Rachael Ray",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Rachael Ray",
            "overview":
                "Rachael Ray, also known as The Rachael Ray Show, is an American talk show starring Rachael Ray that debuted in syndication in the United States and Canada on September 18, 2006. It is filmed at Chelsea Television Studios in New York City. The show's 8th season premiered on September 9, 2013, and became the last Harpo show in syndication to switch to HD with a revamped studio. In January 2012, CBS Television Distribution announced a two-year renewal for the show, taking it through the 2013–14 season.",
            "popularity": 3147.117,
            "poster_path": "/dsAJhCLYX1fiNRoiiJqR6Up4aJ.jpg",
            "vote_average": 5.7,
            "vote_count": 30
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
