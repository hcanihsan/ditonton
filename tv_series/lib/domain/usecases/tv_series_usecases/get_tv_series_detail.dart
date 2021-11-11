import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:tv_series/domain/repositories/tv_series_repositories/tv_series_repository.dart';

class GetTVSeriesDetail {
  final TVSeriesRepository repository;

  GetTVSeriesDetail(this.repository);

  Future<Either<Failure, TVSeriesDetail>> execute(int id) {
    return repository.getTVSeriesDetail(id);
  }
}
