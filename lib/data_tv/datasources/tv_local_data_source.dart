import 'package:ditonton/common/exception.dart';

import '../models/tv_table.dart';
import 'db/database_helper.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvTable movie);
  Future<String> removeWatchlist(TvTable movie);
  Future<TvTable?> getMovieById(int id);
  Future<List<TvTable>> getWatchlistMovies();
  Future<void> cacheNowPlayingMovies (List<TvTable> movies);
  Future<List<TvTable>> getCachedNowPlayingMovies();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    final res= result.map((data) => TvTable.fromMap(data)).toList();
    return res;
  }

  @override
  Future<void> cacheNowPlayingMovies(List<TvTable> movies) async {
    await databaseHelper.clearCache('now playing');
    await databaseHelper.insertCacheTransaction(movies, 'now playing');
  }

  @override
  Future<List<TvTable>> getCachedNowPlayingMovies() async{
    final result = await databaseHelper.getCacheMovies('now playing');
    print('PERNAHKAH ADA');
    print(result.toString());
    if (result.isNotEmpty ) {
      return result.map((data) => TvTable.fromMap(data)).toList();
    }else {
      throw CacheException("Can't get the data :(");
    }
  }



}
