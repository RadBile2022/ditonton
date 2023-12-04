part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();
  @override
  List<Object> get props => [];
}

class OnStatusMovieWatchlistEvent extends MovieWatchlistEvent{
  final int id;
  OnStatusMovieWatchlistEvent(this.id);

  @override
  List<Object> get props => [id];
}
class OnGetMovieWatchlistEvent extends MovieWatchlistEvent{}
class OnAddMovieWatchlistEvent extends MovieWatchlistEvent{
  final MovieDetail movieDetail;
  OnAddMovieWatchlistEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
class OnRemoveMovieWatchlistEvent extends MovieWatchlistEvent{
  final MovieDetail movieDetail;
  OnRemoveMovieWatchlistEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
