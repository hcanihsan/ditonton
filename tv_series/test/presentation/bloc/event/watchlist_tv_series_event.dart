part of '../watchlist_tv_series_bloc.dart';

abstract class WatchlistTVSeriesEvent extends Equatable {
  const WatchlistTVSeriesEvent();

  @override
  List<Object> get props => [];
}

class WatchlistTVSeriesHasDataEvent extends WatchlistTVSeriesEvent {}

class AddWatchlistTVSeriesHasDataEvent extends WatchlistTVSeriesEvent {
  final TVSeriesDetail tvSeries;

  const AddWatchlistTVSeriesHasDataEvent(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class RemoveWatchlistTVSeriesHasDataEvent extends WatchlistTVSeriesEvent {
  final TVSeriesDetail tvSeries;

  const RemoveWatchlistTVSeriesHasDataEvent(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}

class LoadWatchlistStatusHasDataEvent extends WatchlistTVSeriesEvent {
  final int id;

  const LoadWatchlistStatusHasDataEvent(this.id);

  @override
  List<Object> get props => [id];
}
