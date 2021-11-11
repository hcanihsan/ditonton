part of '../popular_tv_series_bloc.dart';

abstract class PopularTVSeriesState extends Equatable {
  const PopularTVSeriesState();

  @override
  List<Object> get props => [];
}

class PopularTVSeriesEmpty extends PopularTVSeriesState {}

class PopularTVSeriesLoading extends PopularTVSeriesState {}

class PopularTVSeriesError extends PopularTVSeriesState {
  final String message;

  const PopularTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTVSeriesHasData extends PopularTVSeriesState {
  final List<TVSeries> result;

  const PopularTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
