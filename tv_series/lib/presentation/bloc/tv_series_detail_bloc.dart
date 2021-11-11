import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_tv_series_detail.dart';
part 'event/tv_series_detail_event.dart';
part 'state/tv_series_detail_state.dart';

class DetailTVSeriesBloc
    extends Bloc<DetailTVSeriesEvent, DetailTVSeriesState> {
  // ignore: unused_field

  final GetTVSeriesDetail _getMovieDetail;

  DetailTVSeriesBloc(this._getMovieDetail) : super(DetailTVSeriesEmpty());

  @override
  Stream<DetailTVSeriesState> mapEventToState(
    DetailTVSeriesEvent event,
  ) async* {
    if (event is DetailTVSeriesHasDataEvent) {
      final id = event.id;

      yield DetailTVSeriesLoading();
      final result = await _getMovieDetail.execute(id);

      yield* result.fold(
        (failure) async* {
          yield DetailTVSeriesError(failure.message);
        },
        (data) async* {
          yield DetailTVSeriesHasData(data);
        },
      );
    }
  }
}
