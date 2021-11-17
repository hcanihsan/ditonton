import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';

import 'search_bloc_tv_series_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late SearchBlocTVSeries searchBlocTVSeries;
  late MockSearchTVSeries mockSearchTVSeries;

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    searchBlocTVSeries = SearchBlocTVSeries(mockSearchTVSeries);
  });

  test('initial state should be empty', () {
    expect(searchBlocTVSeries.state, SearchEmpty());
  });

  final tTVSeriesModel = TVSeries(
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
  final tTVSeriesList = <TVSeries>[tTVSeriesModel];
  const tQuery = 'squid game';

  blocTest<SearchBlocTVSeries, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      return searchBlocTVSeries;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasDataTVSeries(tTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );

  blocTest<SearchBlocTVSeries, SearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchBlocTVSeries;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );
}
