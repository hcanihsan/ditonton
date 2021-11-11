part of '../recommendation_movies_bloc.dart';

abstract class RecommendationMoviesState extends Equatable {
  const RecommendationMoviesState();

  @override
  List<Object> get props => [];
}

class RecommendationMoviesEmpty extends RecommendationMoviesState {}

class RecommendationMoviesLoading extends RecommendationMoviesState {}

class RecommendationMoviesError extends RecommendationMoviesState {
  final String message;

  const RecommendationMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationMoviesHasData extends RecommendationMoviesState {
  final List<Movie> result;

  const RecommendationMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
