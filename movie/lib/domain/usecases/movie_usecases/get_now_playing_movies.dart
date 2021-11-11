import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:movie/domain/repositories/movie_repositories/movie_repository.dart';
import 'package:core/utils/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
