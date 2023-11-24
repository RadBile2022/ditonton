import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton/data_tv/datasources/tv_local_data_source.dart';
import 'package:ditonton/data_tv/datasources/tv_remote_data_source.dart';
import 'package:ditonton/domain_tv/repositories/tv_repository.dart';
import 'package:ditonton/domain_tv/usecases/get_now_playing_tv.dart';
import 'package:ditonton/domain_tv/usecases/get_popular_tv.dart';
import 'package:ditonton/domain_tv/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain_tv/usecases/get_tv_detail.dart';
import 'package:ditonton/domain_tv/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain_tv/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain_tv/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain_tv/usecases/remove_watchlist.dart';
import 'package:ditonton/domain_tv/usecases/save_watchlist.dart';
import 'package:ditonton/domain_tv/usecases/search_movies.dart';
import 'package:ditonton/presentation_tv/provider/playing_now_tv_notifier.dart';
import 'package:ditonton/presentation_tv/provider/popular_tv_notifier.dart';
import 'package:ditonton/presentation_tv/provider/top_rated_tv_notifier.dart';
import 'package:ditonton/presentation_tv/provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation_tv/provider/tv_list_notifier.dart';
import 'package:ditonton/presentation_tv/provider/tv_search_notifier.dart';
import 'package:ditonton/presentation_tv/provider/watchlist_tv_notifier.dart';
import 'package:get_it/get_it.dart';

import 'data_tv/datasources/db/database_helper.dart';
import 'data_tv/repositories/tv_repository_impl.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => TvListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => PlayingNowTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info sudah di injection

  // external sudah di injection
}
