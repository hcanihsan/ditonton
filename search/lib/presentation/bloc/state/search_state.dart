part of '../search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasDataMovie extends SearchState {
  final List<Movie> result;

  const SearchHasDataMovie(this.result);

  @override
  List<Object> get props => [result];
}

class SearchHasDataTVSeries extends SearchState {
  final List<TVSeries> result;

  const SearchHasDataTVSeries(this.result);

  @override
  List<Object> get props => [result];
}
