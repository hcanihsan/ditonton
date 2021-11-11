import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/movie_usecases/get_now_playing_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'event/now_playing_movies_event.dart';
part 'state/now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMovieState> {
  // ignore: unused_field

  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies)
      : super(NowPlayingMovieEmpty());

  @override
  Stream<NowPlayingMovieState> mapEventToState(
    NowPlayingMoviesEvent event,
  ) async* {
    if (event is NowPlayingMovieHasDataEvent) {
      yield NowPlayingMovieLoading();
      final result = await _getNowPlayingMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield NowPlayingMovieError(failure.message);
        },
        (data) async* {
          yield NowPlayingMovieHasData(data);
        },
      );
    }
  }
}
