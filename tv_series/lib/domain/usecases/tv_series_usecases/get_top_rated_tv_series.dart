import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/repositories/tv_series_repositories/tv_series_repository.dart';

class GetTopRatedTVSeries {
  final TVSeriesRepository repository;

  GetTopRatedTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getTopRatedTVSeries();
  }
}
