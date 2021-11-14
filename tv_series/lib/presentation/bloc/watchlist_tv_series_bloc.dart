import 'package:tv_series/domain/usecases/tv_series_usecases/get_watchlist_status_tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_watchlist_tv_series.dart';
part 'event/watchlist_tv_series_event.dart';
part 'state/watchlist_tv_series_state.dart';

class WatchlistTVSeriesBloc
    extends Bloc<WatchlistTVSeriesEvent, WatchlistTVSeriesState> {
  // ignore: unused_field

  final GetWatchlistTVSeries _getWatchlistTVSeries;
  final GetWatchListStatusTVSeries _getWatchListStatus;
  final SaveWatchlistTVSeries _saveWatchlist;
  final RemoveWatchlistTVSeries _removeWatchlist;

  WatchlistTVSeriesBloc(this._getWatchlistTVSeries, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistTVSeriesEmpty());

  @override
  Stream<WatchlistTVSeriesState> mapEventToState(
    WatchlistTVSeriesEvent event,
  ) async* {
    if (event is WatchlistTVSeriesHasDataEvent) {
      yield WatchlistTVSeriesLoading();

      final result = await _getWatchlistTVSeries.execute();
      yield* result.fold(
        (failure) async* {
          yield WatchlistTVSeriesError(failure.message);
        },
        (data) async* {
          yield WatchlistTVSeriesHasData(data);
        },
      );
    } else if (event is AddWatchlistTVSeriesHasDataEvent) {
      final tvSeries = event.tvSeries;
      final result = await _saveWatchlist.execute(tvSeries);
      yield* result.fold((failure) async* {
        yield WatchlistTVSeriesError(failure.message);
      }, (data) async* {
        yield const AddWatchlistTVSeriesHasData(true);
      });
    } else if (event is RemoveWatchlistTVSeriesHasDataEvent) {
      final tvSeries = event.tvSeries;
      final result = await _removeWatchlist.execute(tvSeries);
      yield* result.fold((failure) async* {
        yield WatchlistTVSeriesError(failure.message);
      }, (data) async* {
        yield const RemoveWatchlistTVSeriesHasData(false);
      });
    } else if (event is LoadWatchlistStatusHasDataEvent) {
      final id = event.id;
      final result = await _getWatchListStatus.execute(id);
      yield WatchlistStatusTVSeriesChanged(result);
    }
  }
}
