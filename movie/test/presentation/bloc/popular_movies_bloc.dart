import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/movie_usecases/get_popular_movies.dart';
part 'event/popular_movies_event.dart';
part 'state/popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  // ignore: unused_field

  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(PopularMoviesEmpty());

  @override
  Stream<PopularMoviesState> mapEventToState(
    PopularMoviesEvent event,
  ) async* {
    if (event is PopularMoviesHasDataEvent) {
      yield PopularMoviesLoading();
      final result = await _getPopularMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield PopularMoviesError(failure.message);
        },
        (data) async* {
          yield PopularMoviesHasData(data);
        },
      );
    }
  }
}
