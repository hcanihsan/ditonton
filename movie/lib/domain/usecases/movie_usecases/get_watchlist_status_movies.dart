import 'package:movie/domain/repositories/movie_repositories/movie_repository.dart';

class GetWatchListStatusMovies {
  final MovieRepository repository;

  GetWatchListStatusMovies(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
