import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_watchlist_status_tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/save_watchlist_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_watchlist_tv_series.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTVSeries,
  GetWatchListStatusTVSeries,
  SaveWatchlistTVSeries,
  RemoveWatchlistTVSeries
])
void main() {
  late WatchlistTVSeriesBloc watchlistTVSeriesBloc;

  late MockGetWatchlistTVSeries mockGetWatchlistTVSeries;
  late MockGetWatchListStatusTVSeries mockGetWatchlistStatusTVSeries;
  late MockSaveWatchlistTVSeries mockSaveWatchlistTVSeries;
  late MockRemoveWatchlistTVSeries mockRemoveWatchlistTVSeries;

  setUp(() {
    mockGetWatchlistTVSeries = MockGetWatchlistTVSeries();
    mockGetWatchlistStatusTVSeries = MockGetWatchListStatusTVSeries();
    mockSaveWatchlistTVSeries = MockSaveWatchlistTVSeries();
    mockRemoveWatchlistTVSeries = MockRemoveWatchlistTVSeries();
    watchlistTVSeriesBloc = WatchlistTVSeriesBloc(
        mockGetWatchlistTVSeries,
        mockGetWatchlistStatusTVSeries,
        mockSaveWatchlistTVSeries,
        mockRemoveWatchlistTVSeries);
  });

  test('initial state should be empty', () {
    expect(watchlistTVSeriesBloc.state, WatchlistTVSeriesEmpty());
  });

  // test('should change tv series data when data is gotten successfully',
  //     () async {
  //   // arrange
  //   when(mockGetWatchlistTVSeries.execute())
  //       .thenAnswer((_) async => Right([testWatchlistTVSeries]));
  //   // act
  //   await provider.fetchWatchlistTVSeries();
  //   // assert
  //   expect(provider.watchlistState, RequestState.Loaded);
  //   expect(provider.watchlistTVSeries, [testWatchlistTVSeries]);
  //   expect(listenerCallCount, 2);
  // });

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => Right([testWatchlistTVSeries]));
      return watchlistTVSeriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTVSeriesHasDataEvent()),
    expect: () => [
      WatchlistTVSeriesLoading(),
      WatchlistTVSeriesHasData([testWatchlistTVSeries]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );

  blocTest<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
    'Should emit [Loading, Error] when get watchlist tv series is unsuccessful',
    build: () {
      when(mockGetWatchlistTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistTVSeriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTVSeriesHasDataEvent()),
    expect: () => [
      WatchlistTVSeriesLoading(),
      const WatchlistTVSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTVSeries.execute());
    },
  );
}
