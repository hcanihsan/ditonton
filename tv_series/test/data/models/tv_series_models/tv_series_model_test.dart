import 'package:tv_series/data/models/tv_series_models/tv_series_model.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ignore: prefer_const_constructors
  final tTVSeriesModel = TVSeriesModel(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3],
      id: 1,
      name: 'name',
      originCountry: const ['KO'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 7.0,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1);

  final tTVSeries = TVSeries(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3],
      id: 1,
      name: 'name',
      originCountry: const ['KO'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 7.0,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1);

  test('should be a subclass of tv series entity', () async {
    final result = tTVSeriesModel.toEntity();
    expect(result, tTVSeries);
  });
}
