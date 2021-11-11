part of '../watchlist_movie_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesEmpty extends WatchlistMoviesState {}

class WatchlistMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

// ignore: must_be_immutable
class WatchlistStatusMoviesChanged extends WatchlistMoviesState {
  bool status = false;

  WatchlistStatusMoviesChanged(this.status);

  @override
  List<Object> get props => [status];
}

class WatchlistMoviesHasData extends WatchlistMoviesState {
  final List<Movie> result;

  const WatchlistMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class AddWatchlistMoviesHasData extends WatchlistMoviesState {
  final bool result;

  const AddWatchlistMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class RemoveWatchlistMoviesHasData extends WatchlistMoviesState {
  final bool result;

  const RemoveWatchlistMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

// ignore: must_be_immutable
class LoadWatchlistStatusHasData extends WatchlistMoviesState {
  bool status = false;

  LoadWatchlistStatusHasData(this.status);

  @override
  List<Object> get props => [status];
}
