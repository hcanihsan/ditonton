part of '../now_playing_tv_series_bloc.dart';

abstract class NowPlayingTVSeriesState extends Equatable {
  const NowPlayingTVSeriesState();

  @override
  List<Object> get props => [];
}

class NowPlayingTVSeriesEmpty extends NowPlayingTVSeriesState {}

class NowPlayingTVSeriesLoading extends NowPlayingTVSeriesState {}

class NowPlayingTVSeriesError extends NowPlayingTVSeriesState {
  final String message;

  const NowPlayingTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTVSeriesHasData extends NowPlayingTVSeriesState {
  final List<TVSeries> result;

  const NowPlayingTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
