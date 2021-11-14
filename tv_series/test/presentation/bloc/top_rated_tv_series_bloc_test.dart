import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late TopRatedTVSeriesBloc topRatedTVSeriesBloc;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    topRatedTVSeriesBloc = TopRatedTVSeriesBloc(mockGetTopRatedTVSeries);
  });

  test('initial state should be empty', () {
    expect(topRatedTVSeriesBloc.state, TopRatedTVSeriesEmpty());
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

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      return topRatedTVSeriesBloc;
    },
    act: (bloc) => bloc.add(TopRatedTVSeriesHasDataEvent()),
    expect: () =>
        [TopRatedTVSeriesLoading(), TopRatedTVSeriesHasData(tTVSeriesList)],
    verify: (bloc) {
      verify(mockGetTopRatedTVSeries.execute());
    },
  );

  blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
    'Should emit [Loading, Error] when get top rated tv series is unsuccessful',
    build: () {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTVSeriesBloc;
    },
    act: (bloc) => bloc.add(TopRatedTVSeriesHasDataEvent()),
    expect: () => [
      TopRatedTVSeriesLoading(),
      const TopRatedTVSeriesError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVSeries.execute());
    },
  );
}
