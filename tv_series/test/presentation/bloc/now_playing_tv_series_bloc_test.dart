import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_now_playing_tv_series.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'now_playing_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTVSeries])
void main() {
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeries;
  late NowPlayingTVSeriesBloc nowPlayingTVSeriesBloc;

  setUp(() {
    mockGetNowPlayingTVSeries = MockGetNowPlayingTVSeries();
    nowPlayingTVSeriesBloc = NowPlayingTVSeriesBloc(mockGetNowPlayingTVSeries);
  });

  test('initial state should be empty', () {
    expect(nowPlayingTVSeriesBloc.state, NowPlayingTVSeriesEmpty());
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

  blocTest<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      return nowPlayingTVSeriesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTVSeriesHasDataEvent()),
    expect: () =>
        [NowPlayingTVSeriesLoading(), NowPlayingTVSeriesHasData(tTVSeriesList)],
    verify: (bloc) {
      verify(mockGetNowPlayingTVSeries.execute());
    },
  );

  // test('should return error when data is unsuccessful', () async {
  //   // arrange
  //   when(mockGetNowPlayingTVSeries.execute())
  //       .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
  //   // act
  //   bloc.add(NowPlayingTVSeriesHasDataEvent());
  //   // assert
  //   expect(bloc.state, RequestState.Error);
  //   expect(bloc.state, 'Server Failure');
  //   //expect(listenerCallCount, 2);
  // });

  blocTest<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
    'Should emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetNowPlayingTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingTVSeriesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTVSeriesHasDataEvent()),
    expect: () => [
      NowPlayingTVSeriesLoading(),
      const NowPlayingTVSeriesError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTVSeries.execute());
    },
  );
}
