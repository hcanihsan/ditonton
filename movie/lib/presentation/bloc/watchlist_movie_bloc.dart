import 'package:movie/domain/usecases/movie_usecases/get_watchlist_status_movies.dart';
import 'package:movie/domain/usecases/movie_usecases/remove_watchlist_movies.dart';
import 'package:movie/domain/usecases/movie_usecases/save_watchlist_movies.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_entities/movie_detail.dart';
import 'package:movie/domain/usecases/movie_usecases/get_watchlist_movies.dart';
part 'event/watchlist_movie_event.dart';
part 'state/watchlist_movie_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatusMovies _getWatchListStatus;
  final SaveWatchlistMovies _saveWatchlist;
  final RemoveWatchlistMovies _removeWatchlist;

  WatchlistMoviesBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistMoviesEmpty());

  @override
  Stream<WatchlistMoviesState> mapEventToState(
    WatchlistMoviesEvent event,
  ) async* {
    if (event is WatchlistMoviesHasDataEvent) {
      yield WatchlistMoviesLoading();

      final result = await _getWatchlistMovies.execute();
      yield* result.fold(
        (failure) async* {
          yield WatchlistMoviesError(failure.message);
        },
        (data) async* {
          yield WatchlistMoviesHasData(data);
        },
      );
    } else if (event is AddWatchlistMoviesHasDataEvent) {
      final movie = event.movie;
      final result = await _saveWatchlist.execute(movie);
      yield* result.fold((failure) async* {
        yield WatchlistMoviesError(failure.message);
      }, (data) async* {
        yield const AddWatchlistMoviesHasData(true);
      });
    } else if (event is RemoveWatchlistMoviesHasDataEvent) {
      final movie = event.movie;
      final result = await _removeWatchlist.execute(movie);
      yield* result.fold((failure) async* {
        yield WatchlistMoviesError(failure.message);
      }, (data) async* {
        yield const RemoveWatchlistMoviesHasData(false);
      });
    } else if (event is LoadWatchlistStatusHasDataEvent) {
      final id = event.id;
      final result = await _getWatchListStatus.execute(id);
      yield WatchlistStatusMoviesChanged(result);
    }
  }
}
