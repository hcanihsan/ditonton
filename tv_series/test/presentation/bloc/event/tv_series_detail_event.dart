part of '../tv_series_detail_bloc.dart';

abstract class DetailTVSeriesEvent extends Equatable {
  const DetailTVSeriesEvent();

  @override
  List<Object> get props => [];
}

class DetailTVSeriesHasDataEvent extends DetailTVSeriesEvent {
  final int id;

  const DetailTVSeriesHasDataEvent(this.id);

  @override
  List<Object> get props => [id];
}
