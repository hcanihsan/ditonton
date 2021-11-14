import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesDetail])
void main() {
  late DetailTVSeriesBloc detailTVSeriesBloc;
  late MockGetTVSeriesDetail mockDetailTVSeries;

  setUp(() {
    mockDetailTVSeries = MockGetTVSeriesDetail();
    detailTVSeriesBloc = DetailTVSeriesBloc(mockDetailTVSeries);
  });

  test('initial state should be empty', () {
    expect(detailTVSeriesBloc.state, DetailTVSeriesEmpty());
  });

  const tId = 1;

  blocTest<DetailTVSeriesBloc, DetailTVSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockDetailTVSeries.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesDetail));
      return detailTVSeriesBloc;
    },
    act: (bloc) => bloc.add(const DetailTVSeriesHasDataEvent(tId)),
    expect: () => [
      DetailTVSeriesLoading(),
      DetailTVSeriesHasData(testTVSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockDetailTVSeries.execute(tId));
    },
  );

  blocTest<DetailTVSeriesBloc, DetailTVSeriesState>(
    'Should emit [Loading, Error] when get detail tv series is unsuccessful',
    build: () {
      when(mockDetailTVSeries.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailTVSeriesBloc;
    },
    act: (bloc) => bloc.add(const DetailTVSeriesHasDataEvent(tId)),
    expect: () => [
      DetailTVSeriesLoading(),
      const DetailTVSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockDetailTVSeries.execute(tId));
    },
  );
}
