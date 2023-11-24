import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';

import '../entities/tv.dart';
import '../entities/tv_detail.dart';


abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getNowPlayingMovies();
  Future<Either<Failure, List<Tv>>> getPopularMovies();
  Future<Either<Failure, List<Tv>>> getTopRatedMovies();
  Future<Either<Failure, TvDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Tv>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlist(TvDetail movie);
  Future<Either<Failure, String>> removeWatchlist(TvDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistMovies();
}
