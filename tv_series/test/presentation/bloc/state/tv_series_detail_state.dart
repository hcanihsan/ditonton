part of '../tv_series_detail_bloc.dart';

abstract class DetailTVSeriesState extends Equatable {
  const DetailTVSeriesState();

  @override
  List<Object> get props => [];
}

class DetailTVSeriesEmpty extends DetailTVSeriesState {}

class DetailTVSeriesLoading extends DetailTVSeriesState {}

class DetailTVSeriesError extends DetailTVSeriesState {
  final String message;

  const DetailTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTVSeriesHasData extends DetailTVSeriesState {
  final TVSeriesDetail result;

  const DetailTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
