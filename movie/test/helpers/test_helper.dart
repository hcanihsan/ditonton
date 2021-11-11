import 'package:core/data/datasources/db/database_helper.dart';
import 'package:movie/data/datasources/movie_datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_datasources/movie_remote_data_source.dart';
import 'package:movie/domain/repositories/movie_repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
