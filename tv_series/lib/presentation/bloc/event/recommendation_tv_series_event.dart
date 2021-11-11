part of '../recommendation_tv_series_bloc.dart';

abstract class RecommendationTVSeriesEvent extends Equatable {
  const RecommendationTVSeriesEvent();

  @override
  List<Object> get props => [];
}

class RecommendationTVSeriesHasDataEvent extends RecommendationTVSeriesEvent {
  final int id;

  const RecommendationTVSeriesHasDataEvent(this.id);

  @override
  List<Object> get props => [id];
}
