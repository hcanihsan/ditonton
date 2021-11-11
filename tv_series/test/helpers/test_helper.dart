import 'package:core/data/datasources/db/database_helper.dart';
import 'package:tv_series/data/datasources/tv_series_datasources/tv_series_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/domain/repositories/tv_series_repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
