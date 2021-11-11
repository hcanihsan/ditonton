import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_entities/movie_detail.dart';
import 'package:movie/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'event/movie_detail_event.dart';
part 'state/movie_detail_state.dart';

class DetailMoviesBloc extends Bloc<DetailMoviesEvent, DetailMoviesState> {
  // ignore: unused_field

  final GetMovieDetail _getMovieDetail;

  DetailMoviesBloc(this._getMovieDetail) : super(DetailMoviesEmpty());

  @override
  Stream<DetailMoviesState> mapEventToState(
    DetailMoviesEvent event,
  ) async* {
    if (event is DetailMoviesHasDataEvent) {
      final id = event.id;

      yield DetailMoviesLoading();
      final result = await _getMovieDetail.execute(id);

      yield* result.fold(
        (failure) async* {
          yield DetailMoviesError(failure.message);
        },
        (data) async* {
          yield DetailMoviesHasData(data);
        },
      );
    }
  }
}
