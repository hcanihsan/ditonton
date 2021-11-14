import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late DetailMoviesBloc detailMoviesBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMoviesBloc = DetailMoviesBloc(mockGetMovieDetail);
  });

  test('initial state should be empty', () {
    expect(detailMoviesBloc.state, DetailMoviesEmpty());
  });

  const tId = 1;

  blocTest<DetailMoviesBloc, DetailMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return detailMoviesBloc;
    },
    act: (bloc) => bloc.add(const DetailMoviesHasDataEvent(tId)),
    expect: () => [
      DetailMoviesLoading(),
      DetailMoviesHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );

  blocTest<DetailMoviesBloc, DetailMoviesState>(
    'Should emit [Loading, Error] when get detail movies is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailMoviesBloc;
    },
    act: (bloc) => bloc.add(const DetailMoviesHasDataEvent(tId)),
    expect: () => [
      DetailMoviesLoading(),
      const DetailMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );
}
