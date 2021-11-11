part of '../now_playing_tv_series_bloc.dart';

abstract class NowPlayingTVSeriesEvent extends Equatable {
  const NowPlayingTVSeriesEvent();

  @override
  List<Object> get props => [];
}

class NowPlayingTVSeriesHasDataEvent extends NowPlayingTVSeriesEvent {}
