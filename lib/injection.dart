import 'package:core/data/datasources/db/database_helper.dart';
import 'package:movie/data/datasources/movie_datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_datasources/movie_remote_data_source.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:tv_series/data/datasources/tv_series_datasources/tv_series_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_datasources/tv_series_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository/movie_repository_impl.dart';
import 'package:tv_series/data/repositories/tv_series_repository/tv_series_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repositories/movie_repository.dart';
import 'package:tv_series/domain/repositories/tv_series_repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/movie_usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/movie_usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/movie_usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/movie_usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/movie_usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/movie_usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_now_playing_tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/tv_series_usecases/get_watchlist_tv_series.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:search/search.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchBlocMovie(
      locator(),
    ),
  );

  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistMoviesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => DetailMoviesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => RecommendationMoviesBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());

  //--------------------- For TV Series ----------------------------//

  // bloc
  locator.registerFactory(
    () => SearchBlocTVSeries(
      locator(),
    ),
  );

  locator.registerFactory(
    () => NowPlayingTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTVSeriesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTVSeriesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => DetailTVSeriesBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => RecommendationTVSeriesBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTVSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeries(locator()));

  // repository
  locator.registerLazySingleton<TVSeriesRepository>(
    () => TVSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
      () => TVSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
      () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()));
}
