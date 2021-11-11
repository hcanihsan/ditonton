import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_now_playing_tv_series.dart';
part 'event/now_playing_tv_series_event.dart';
part 'state/now_playing_tv_series_state.dart';

class NowPlayingTVSeriesBloc
    extends Bloc<NowPlayingTVSeriesEvent, NowPlayingTVSeriesState> {
  // ignore: unused_field

  final GetNowPlayingTVSeries _getNowPlayingTVSeries;

  NowPlayingTVSeriesBloc(this._getNowPlayingTVSeries)
      : super(NowPlayingTVSeriesEmpty());

  @override
  Stream<NowPlayingTVSeriesState> mapEventToState(
    NowPlayingTVSeriesEvent event,
  ) async* {
    if (event is NowPlayingTVSeriesHasDataEvent) {
      yield NowPlayingTVSeriesLoading();
      final result = await _getNowPlayingTVSeries.execute();
      yield* result.fold(
        (failure) async* {
          yield NowPlayingTVSeriesError(failure.message);
        },
        (data) async* {
          yield NowPlayingTVSeriesHasData(data);
        },
      );
    }
  }
}
