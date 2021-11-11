import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_top_rated_tv_series.dart';
part 'event/top_rated_tv_series_event.dart';
part 'state/top_rated_tv_series_state.dart';

class TopRatedTVSeriesBloc
    extends Bloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState> {
  // ignore: unused_field

  final GetTopRatedTVSeries _getTopRatedTVSeries;

  TopRatedTVSeriesBloc(this._getTopRatedTVSeries)
      : super(TopRatedTVSeriesEmpty());

  @override
  Stream<TopRatedTVSeriesState> mapEventToState(
    TopRatedTVSeriesEvent event,
  ) async* {
    if (event is TopRatedTVSeriesHasDataEvent) {
      yield TopRatedTVSeriesLoading();
      final result = await _getTopRatedTVSeries.execute();
      yield* result.fold(
        (failure) async* {
          yield TopRatedTVSeriesError(failure.message);
        },
        (data) async* {
          yield TopRatedTVSeriesHasData(data);
        },
      );
    }
  }
}
