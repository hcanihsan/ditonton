import 'package:tv_series/data/models/tv_series_models/tv_series_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series_detail.dart';

//For TV Series Object
final testTVSeries = TVSeries(
  backdropPath: '/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg',
  genreIds: const [10759, 9648, 18],
  id: 93405,
  originalName: '오징어 게임',
  overview:
      'Hundreds of cash-strapped players accept a strange invitation to compete in children\'s games—with high stakes. But, a tempting prize awaits the victor.',
  popularity: 5200.044,
  posterPath: '/dDlEmu3EZ0Pgg93K2SVNLCjCSvE.jpg',
  originalLanguage: 'ko',
  name: 'Squid Game',
  originCountry: const ['KR'],
  voteAverage: 7.8,
  voteCount: 7842,
);

final testTvSeriesList = [testTVSeries];

final testTVSeriesDetail = TVSeriesDetail(
    backdropPath: 'backdropPath',
    // ignore: prefer_const_literals_to_create_immutables
    createdBy: [
      // ignore: prefer_const_literals_to_create_immutables
      {
        "id": 1,
        "credit_id": '1c',
        "name": 'name',
        "gender": 2,
        "profile_path": 'profile_path.jpg'
      }
    ],
    episodeRunTime: const [54],
    genres: const [Genre(id: 1, name: 'Action')],
    homepage: 'homepage',
    id: 1,
    inProduction: true,
    languages: const ['en', 'el'],
    lastAirDate: DateTime.parse('2021-10-20'),
    name: 'name',
    originCountry: const ['KR'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1431.914,
    posterPath: 'posterPath',
    productionCompanies: const [
      {"id": 1, "logo_path": null, "name": 'name', "origin_country": 'KR'}
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 5.2,
    voteCount: 5);

final testWatchlistTVSeries = TVSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

// ignore: prefer_const_constructors
final testTVSeriesTable = TVSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
