import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movies_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/movie_pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/movie_pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/movie_pages/watchlist_movies_page.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:tv_series/presentation/pages/tv_series_pages/home_tv_series_page.dart';
import 'package:tv_series/presentation/pages/tv_series_pages/now_playing_tv_series_page.dart';
import 'package:tv_series/presentation/pages/tv_series_pages/popular_tv_series_page.dart';
import 'package:tv_series/presentation/pages/tv_series_pages/top_rated_tv_series_page.dart';
import 'package:tv_series/presentation/pages/tv_series_pages/tv_series_detail_page.dart';
import 'package:tv_series/presentation/pages/tv_series_pages/watchlist_tv_series_page.dart';
import 'package:core/presentation/pages/watchlist_choose_page.dart';
import 'package:core/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/search.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<DetailMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBlocMovie>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBlocTVSeries>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTVSeriesBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          // ignore: deprecated_member_use
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case NOW_PLAYING_TV_SERIES_ROUTE:
              return CupertinoPageRoute(
                  builder: (_) => NowPlayingTVSeriesPage());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case POPULAR_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTVSeriesPage());
            case TOP_RATED_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TOP_RATED_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedTVSeriesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TV_SERIES_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVSeriesDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_MOVIE_ROUTE:
              return CupertinoPageRoute(builder: (_) => MovieSearchPage());
            case SEARCH_TV_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => TVSeriesSearchPage());
            case HOME_TV_SERIES_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeTVSeriesPage());
            case WATCHLIST_CHOOSE_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistChoosePage());
            case WATCHLIST_MOVIE_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WATCHLIST_TV_SERIES:
              return MaterialPageRoute(builder: (_) => WatchlistTVSeriesPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
