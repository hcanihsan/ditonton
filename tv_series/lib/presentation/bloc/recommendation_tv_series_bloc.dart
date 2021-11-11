import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_tv_series_recommendations.dart';

part 'event/recommendation_tv_series_event.dart';
part 'state/recommendation_tv_series_state.dart';

class RecommendationTVSeriesBloc
    extends Bloc<RecommendationTVSeriesEvent, RecommendationTVSeriesState> {
  // ignore: unused_field

  final GetTVSeriesRecommendations _getTVSeriesRecommendations;

  RecommendationTVSeriesBloc(this._getTVSeriesRecommendations)
      : super(RecommendationTVSeriesEmpty());

  @override
  Stream<RecommendationTVSeriesState> mapEventToState(
    RecommendationTVSeriesEvent event,
  ) async* {
    if (event is RecommendationTVSeriesHasDataEvent) {
      final id = event.id;
      yield RecommendationTVSeriesLoading();
      final result = await _getTVSeriesRecommendations.execute(id);
      yield* result.fold(
        (failure) async* {
          yield RecommendationTVSeriesError(failure.message);
        },
        (data) async* {
          yield RecommendationTVSeriesHasData(data);
        },
      );
    }
  }
}
