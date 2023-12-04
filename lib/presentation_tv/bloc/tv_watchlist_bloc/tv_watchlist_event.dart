part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();
  @override
  List<Object> get props => [];
}

class OnStatusTvWatchlistEvent extends TvWatchlistEvent{
  final int id;
  OnStatusTvWatchlistEvent(this.id);

  @override
  List<Object> get props => [id];
}
class OnGetTvWatchlistEvent extends TvWatchlistEvent{}
class OnAddTvWatchlistEvent extends TvWatchlistEvent{
  final TvDetail tvDetail;
  OnAddTvWatchlistEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
class OnRemoveTvWatchlistEvent extends TvWatchlistEvent{
  final TvDetail tvDetail;
  OnRemoveTvWatchlistEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
