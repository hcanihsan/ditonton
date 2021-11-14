import 'package:tv_series/domain/repositories/tv_series_repositories/tv_series_repository.dart';

class GetWatchListStatusTVSeries {
  final TVSeriesRepository repository;

  GetWatchListStatusTVSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
