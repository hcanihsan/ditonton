part of '../recommendation_tv_series_bloc.dart';

abstract class RecommendationTVSeriesState extends Equatable {
  const RecommendationTVSeriesState();

  @override
  List<Object> get props => [];
}

class RecommendationTVSeriesEmpty extends RecommendationTVSeriesState {}

class RecommendationTVSeriesLoading extends RecommendationTVSeriesState {}

class RecommendationTVSeriesError extends RecommendationTVSeriesState {
  final String message;

  const RecommendationTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationTVSeriesHasData extends RecommendationTVSeriesState {
  final List<TVSeries> result;

  const RecommendationTVSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
