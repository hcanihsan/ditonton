import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;
  late SearchTVSeries usecaseTVSeries;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecaseTVSeries = SearchTVSeries(mockTVSeriesRepository);
  });

  final tMovies = <Movie>[];
  // ignore: prefer_const_declarations
  final tQuery = 'Spiderman';

  final tTVSeries = <TVSeries>[];
  // ignore: prefer_const_declarations
  final tQueryTV = 'Squid Game';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tMovies));
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.searchTVSeries(tQueryTV))
        .thenAnswer((_) async => Right(tTVSeries));
    // act
    final result = await usecaseTVSeries.execute(tQueryTV);
    // assert
    expect(result, Right(tTVSeries));
  });
}
