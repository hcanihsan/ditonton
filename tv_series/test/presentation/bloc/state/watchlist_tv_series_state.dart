part of '../watchlist_tv_series_bloc.dart';

abstract class WatchlistTVSeriesState extends Equatable {
  const WatchlistTVSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesEmpty extends WatchlistTVSeriesState {}

class WatchlistTVSeriesLoading extends WatchlistTVSeriesState {}

class WatchlistTVSeriesError extends WatchlistTVSeriesState {
  final String message;

  const WatchlistTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

// ignore: must_be_immutable
class WatchlistStatusTVSeriesChanged extends WatchlistTVSeriesState {
  bool status = false;

  WatchlistStatusTVSeriesChanged(this.status);

  @override
  List<Object> get props => [status];
}

class WatchlistTVSeriesHasData extends WatchlistTVSeriesState {
  final List<TVSeries> result;

  const WatchlistTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class AddWatchlistTVSeriesHasData extends WatchlistTVSeriesState {
  final bool result;

  const AddWatchlistTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class RemoveWatchlistTVSeriesHasData extends WatchlistTVSeriesState {
  final bool result;

  const RemoveWatchlistTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

// ignore: must_be_immutable
class LoadWatchlistStatusHasData extends WatchlistTVSeriesState {
  bool status = false;

  LoadWatchlistStatusHasData(this.status);

  @override
  List<Object> get props => [status];
}
