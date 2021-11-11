import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_popular_tv_series.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late PopularTVSeriesBloc popularTVSeriesBloc;

  setUp(() {
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    popularTVSeriesBloc = PopularTVSeriesBloc(mockGetPopularTVSeries);
  });

  test('initial state should be empty', () {
    expect(popularTVSeriesBloc.state, PopularTVSeriesEmpty());
  });

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

  final tTVSeriesList = <TVSeries>[tTVSeries];

  blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      return popularTVSeriesBloc;
    },
    act: (bloc) => bloc.add(PopularTVSeriesHasDataEvent()),
    expect: () =>
        [PopularTVSeriesLoading(), PopularTVSeriesHasData(tTVSeriesList)],
    verify: (bloc) {
      verify(mockGetPopularTVSeries.execute());
    },
  );

  blocTest<PopularTVSeriesBloc, PopularTVSeriesState>(
    'Should emit [Loading, Error] when get popular tv series is unsuccessful',
    build: () {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTVSeriesBloc;
    },
    act: (bloc) => bloc.add(PopularTVSeriesHasDataEvent()),
    expect: () => [
      PopularTVSeriesLoading(),
      const PopularTVSeriesError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetPopularTVSeries.execute());
    },
  );
}
