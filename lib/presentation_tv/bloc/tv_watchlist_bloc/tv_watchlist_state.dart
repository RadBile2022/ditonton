part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistInitial extends TvWatchlistState {}

class TvWatchlistLoading extends TvWatchlistState {}

class TvWatchlistError extends TvWatchlistState {
  final String message;

  TvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvStatusWatchlistHasData extends TvWatchlistState {
  bool isAdded;

  TvStatusWatchlistHasData(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class TvAddWatchlistHasData extends TvWatchlistState {
  final String message;

  TvAddWatchlistHasData(this.message);

  @override
  List<Object> get props => [message];
}

class TvRemoveWatchlistHasData extends TvWatchlistState {
  final String message;

  TvRemoveWatchlistHasData(this.message);

  @override
  List<Object> get props => [message];
}

class TvGetWatchlistHasData extends TvWatchlistState {
  List<Tv> Tvs;

  TvGetWatchlistHasData(this.Tvs);

  @override
  List<Object> get props => [Tvs];
}
