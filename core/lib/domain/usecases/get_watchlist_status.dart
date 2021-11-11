import 'package:movie/domain/repositories/movie_repositories/movie_repository.dart';
import 'package:tv_series/domain/repositories/tv_series_repositories/tv_series_repository.dart';

class GetWatchListStatus {
  final MovieRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}

class GetWatchListStatusTVSeries {
  final TVSeriesRepository repository;

  GetWatchListStatusTVSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
