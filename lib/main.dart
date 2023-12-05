import 'dart:developer';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc/recommendations/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list_bloc/now_playing/now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list_bloc/popular/popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list_bloc/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation_tv/bloc/tv_detail_bloc/detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_detail_bloc/recommendations/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_list_bloc/now_playing/now_playing_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_list_bloc/popular/popular_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_list_bloc/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation_tv/pages/home_tv_page.dart';
import 'package:ditonton/presentation_tv/pages/playing_now_tv_page.dart';
import 'package:ditonton/presentation_tv/pages/popular_tv_page.dart';
import 'package:ditonton/presentation_tv/pages/search_page.dart';
import 'package:ditonton/presentation_tv/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation_tv/pages/tv_detail_page.dart';
import 'package:ditonton/presentation_tv/pages/watchlist_tv_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/injection_tv.dart' as di_tv;

import 'common/ssl-pinning.dart';
import 'firebase_options.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      log("CHANGE $bloc $change");
    }
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    if (kDebugMode) {
      log("CHANGE $bloc $event");
    }
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    if (kDebugMode) {
      log("CHANGE $bloc $transition");
    }
    super.onTransition(bloc, transition);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  di_tv.init();

  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieSearchBloc>(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider<NowPlayingBloc>(
          create: (_) =>
              di.locator<NowPlayingBloc>()..add(OnGetNowPlayingMoviesFetch()),
        ),
        BlocProvider<PopularBloc>(
          create: (_) =>
              di.locator<PopularBloc>()..add(OnGetPopularMoviesFetch()),
        ),
        BlocProvider<TopRatedBloc>(
          create: (_) =>
              di.locator<TopRatedBloc>()..add(OnGetTopRatedMoviesFetch()),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),

        /// TV SERIES
        BlocProvider<TvSearchBloc>(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider<NowPlayingTvBloc>(
          create: (_) =>
          di.locator<NowPlayingTvBloc>()..add(OnGetNowPlayingTvFetch()),
        ),
        BlocProvider<PopularTvBloc>(
          create: (_) =>
          di.locator<PopularTvBloc>()..add(OnGetPopularTvFetch()),
        ),
        BlocProvider<TopRatedTvBloc>(
          create: (_) =>
          di.locator<TopRatedTvBloc>()..add(OnGetTopRatedTvFetch()),
        ),
        BlocProvider<TvDetailBloc>(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider<TvRecommendationBloc>(
          create: (_) => di.locator<TvRecommendationBloc>(),
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
      ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
          ),
          home: HomeMoviePage(),
          navigatorObservers: [routeObserver],

          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/home':
                return MaterialPageRoute(builder: (_) => HomeMoviePage());
              case PopularMoviesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
              case TopRatedMoviesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
              case MovieDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id),
                  settings: settings,
                );
              case SearchPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => SearchPage());
              case WatchlistMoviesPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
              case AboutPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => AboutPage());

              /// TV Series
              case HomeTvPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => HomeTvPage());
              case PlayingNowTvPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => PlayingNowTvPage());
              case PopularTvPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => PopularTvPage());
              case TopRatedTvPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
              case TvDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => TvDetailPage(id: id),
                  settings: settings,
                );
              case SearchPageTv.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => SearchPageTv());
              case WatchlistTvPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => WatchlistTvPage());
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
