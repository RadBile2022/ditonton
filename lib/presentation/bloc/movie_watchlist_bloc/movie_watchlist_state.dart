part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieStatusWatchlistHasData extends MovieWatchlistState {
  bool isAdded;

  MovieStatusWatchlistHasData(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class MovieAddWatchlistHasData extends MovieWatchlistState {
  final String message;

  MovieAddWatchlistHasData(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRemoveWatchlistHasData extends MovieWatchlistState {
  final String message;

  MovieRemoveWatchlistHasData(this.message);

  @override
  List<Object> get props => [message];
}

class MovieGetWatchlistHasData extends MovieWatchlistState {
  List<Movie> movies;

  MovieGetWatchlistHasData(this.movies);

  @override
  List<Object> get props => [movies];
}
