import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
part 'event/search_event.dart';
part 'state/search_state.dart';

class SearchBlocMovie extends Bloc<SearchEvent, SearchState> {
  // ignore: unused_field
  final SearchMovies _searchMovies;

  SearchBlocMovie(this._searchMovies) : super(SearchEmpty());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is OnQueryChanged) {
      final query = event.query;

      yield SearchLoading();
      final result = await _searchMovies.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchError(failure.message);
        },
        (data) async* {
          yield SearchHasDataMovie(data);
        },
      );
    }
  }

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    // ignore: deprecated_member_use
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    // ignore: deprecated_member_use
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }
}

class SearchBlocTVSeries extends Bloc<SearchEvent, SearchState> {
  // ignore: unused_field
  final SearchTVSeries _searchTVSeries;

  SearchBlocTVSeries(this._searchTVSeries) : super(SearchEmpty());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is OnQueryChanged) {
      final query = event.query;

      yield SearchLoading();
      final result = await _searchTVSeries.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchError(failure.message);
        },
        (data) async* {
          yield SearchHasDataTVSeries(data);
        },
      );
    }
  }

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    // ignore: deprecated_member_use
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    // ignore: deprecated_member_use
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }
}
