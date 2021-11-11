import 'package:core/data/datasources/db/database_helper.dart';
import 'package:movie/data/datasources/movie_datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_datasources/movie_remote_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_datasources/tv_series_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_datasources/tv_series_remote_data_source.dart';
import 'package:movie/domain/repositories/movie_repositories/movie_repository.dart';
import 'package:tv_series/domain/repositories/tv_series_repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
