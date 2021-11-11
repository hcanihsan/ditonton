import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_series_bloc.dart';

import 'recommendation_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesRecommendations])
void main() {
  late RecommendationTVSeriesBloc recommendationTVSeriesBloc;
  late MockGetTVSeriesRecommendations mockRecommendationTVSeries;

  setUp(() {
    mockRecommendationTVSeries = MockGetTVSeriesRecommendations();
    recommendationTVSeriesBloc =
        RecommendationTVSeriesBloc(mockRecommendationTVSeries);
  });

  test('initial state should be empty', () {
    expect(recommendationTVSeriesBloc.state, RecommendationTVSeriesEmpty());
  });

// ignore: prefer_const_declarations
  final tId = 1;

  final tTVSeries = TVSeries(
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
  final tSeriesTV = <TVSeries>[tTVSeries];

  blocTest<RecommendationTVSeriesBloc, RecommendationTVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockRecommendationTVSeries.execute(tId))
          .thenAnswer((_) async => Right(tSeriesTV));
      return recommendationTVSeriesBloc;
    },
    act: (bloc) => bloc.add(RecommendationTVSeriesHasDataEvent(tId)),
    expect: () => [
      RecommendationTVSeriesLoading(),
      RecommendationTVSeriesHasData(tSeriesTV),
    ],
    verify: (bloc) {
      verify(mockRecommendationTVSeries.execute(tId));
    },
  );

  blocTest<RecommendationTVSeriesBloc, RecommendationTVSeriesState>(
    'Should emit [Loading, Error] when get recommendation is unsuccessful',
    build: () {
      when(mockRecommendationTVSeries.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationTVSeriesBloc;
    },
    act: (bloc) => bloc.add(RecommendationTVSeriesHasDataEvent(tId)),
    expect: () => [
      RecommendationTVSeriesLoading(),
      const RecommendationTVSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockRecommendationTVSeries.execute(tId));
    },
  );
}
