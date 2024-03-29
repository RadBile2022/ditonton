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
import 'package:ditonton/presentation_tv/bloc/tv_detail_bloc/detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_detail_bloc/recommendations/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_list_bloc/now_playing/now_playing_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_list_bloc/popular/popular_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_list_bloc/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data_tv/datasources/db/database_helper.dart';
import 'data_tv/repositories/tv_repository_impl.dart';

final locator = GetIt.instance;

void init() {
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

  // bloc
  locator.registerFactory(
        () => TvSearchBloc(locator()),
  );
  locator.registerFactory(
        () => NowPlayingTvBloc(
      getNowPlayingTvs: locator(),
    ),
  );
  locator.registerFactory(
        () => PopularTvBloc(
      getPopularTvs:  locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedTvBloc(
      getTopRatedTvs:  locator(),
    ),
  );
  locator.registerFactory(
        () => TvDetailBloc(
      detailResult: locator(),
      getTvRecommendations:   locator(),
      getWatchListStatus: locator(),
    ),
  );
  locator.registerFactory(
        () => TvRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
}
