part of '../watchlist_movie_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesHasDataEvent extends WatchlistMoviesEvent {}

class AddWatchlistMoviesHasDataEvent extends WatchlistMoviesEvent {
  final MovieDetail movie;

  const AddWatchlistMoviesHasDataEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveWatchlistMoviesHasDataEvent extends WatchlistMoviesEvent {
  final MovieDetail movie;

  const RemoveWatchlistMoviesHasDataEvent(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatusHasDataEvent extends WatchlistMoviesEvent {
  final int id;

  const LoadWatchlistStatusHasDataEvent(this.id);

  @override
  List<Object> get props => [id];
}
