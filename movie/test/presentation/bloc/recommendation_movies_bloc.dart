import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/movie_usecases/get_movie_recommendations.dart';
part 'event/recommendation_movies_event.dart';
part 'state/recommendation_movies_state.dart';

class RecommendationMoviesBloc
    extends Bloc<RecommendationMoviesEvent, RecommendationMoviesState> {
  // ignore: unused_field

  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMoviesBloc(this._getMovieRecommendations)
      : super(RecommendationMoviesEmpty());

  @override
  Stream<RecommendationMoviesState> mapEventToState(
    RecommendationMoviesEvent event,
  ) async* {
    if (event is RecommendationMoviesHasDataEvent) {
      final id = event.id;
      yield RecommendationMoviesLoading();
      final result = await _getMovieRecommendations.execute(id);
      yield* result.fold(
        (failure) async* {
          yield RecommendationMoviesError(failure.message);
        },
        (data) async* {
          yield RecommendationMoviesHasData(data);
        },
      );
    }
  }
}
