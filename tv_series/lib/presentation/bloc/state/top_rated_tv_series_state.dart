part of '../top_rated_tv_series_bloc.dart';

abstract class TopRatedTVSeriesState extends Equatable {
  const TopRatedTVSeriesState();

  @override
  List<Object> get props => [];
}

class TopRatedTVSeriesEmpty extends TopRatedTVSeriesState {}

class TopRatedTVSeriesLoading extends TopRatedTVSeriesState {}

class TopRatedTVSeriesError extends TopRatedTVSeriesState {
  final String message;

  const TopRatedTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTVSeriesHasData extends TopRatedTVSeriesState {
  final List<TVSeries> result;

  const TopRatedTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
