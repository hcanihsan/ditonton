import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/movie_usecases/get_top_rated_movies.dart';
part 'event/top_rated_movies_event.dart';
part 'state/top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  // ignore: unused_field

  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(TopRatedMoviesEmpty());

  @override
  Stream<TopRatedMoviesState> mapEventToState(
    TopRatedMoviesEvent event,
  ) async* {
    if (event is TopRatedMoviesHasDataEvent) {
      yield TopRatedMoviesLoading();
      final result = await _getTopRatedMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield TopRatedMoviesError(failure.message);
        },
        (data) async* {
          yield TopRatedMoviesHasData(data);
        },
      );
    }
  }
}
