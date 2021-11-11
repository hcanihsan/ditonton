part of '../recommendation_movies_bloc.dart';

abstract class RecommendationMoviesEvent extends Equatable {
  const RecommendationMoviesEvent();

  @override
  List<Object> get props => [];
}

class RecommendationMoviesHasDataEvent extends RecommendationMoviesEvent {
  final int id;

  const RecommendationMoviesHasDataEvent(this.id);

  @override
  List<Object> get props => [id];
}
