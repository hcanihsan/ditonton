import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_popular_tv_series.dart';
part 'event/popular_tv_series_event.dart';
part 'state/popular_tv_series_state.dart';

class PopularTVSeriesBloc
    extends Bloc<PopularTVSeriesEvent, PopularTVSeriesState> {
  // ignore: unused_field

  final GetPopularTVSeries _getPopularTVSeries;

  PopularTVSeriesBloc(this._getPopularTVSeries) : super(PopularTVSeriesEmpty());

  @override
  Stream<PopularTVSeriesState> mapEventToState(
    PopularTVSeriesEvent event,
  ) async* {
    if (event is PopularTVSeriesHasDataEvent) {
      yield PopularTVSeriesLoading();
      final result = await _getPopularTVSeries.execute();
      yield* result.fold(
        (failure) async* {
          yield PopularTVSeriesError(failure.message);
        },
        (data) async* {
          yield PopularTVSeriesHasData(data);
        },
      );
    }
  }
}
