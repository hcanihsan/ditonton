part of '../movie_detail_bloc.dart';

abstract class DetailMoviesEvent extends Equatable {
  const DetailMoviesEvent();

  @override
  List<Object> get props => [];
}

class DetailMoviesHasDataEvent extends DetailMoviesEvent {
  final int id;

  const DetailMoviesHasDataEvent(this.id);

  @override
  List<Object> get props => [id];
}
