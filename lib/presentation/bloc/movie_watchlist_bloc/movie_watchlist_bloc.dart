import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_watchlist_movies.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';

part 'movie_watchlist_event.dart';

part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistBloc(
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
    this.getWatchlistMovies,
  ) : super(MovieWatchlistInitial()) {
    on<OnStatusMovieWatchlistEvent>((event, emit) async {
      emit(MovieWatchlistLoading());
      final id = event.id;
      final result = await getWatchListStatus.execute(id);
      emit(MovieStatusWatchlistHasData(result));
    });
    on<OnAddMovieWatchlistEvent>((event, emit) async {
      emit(MovieWatchlistLoading());
      final movieDetail = event.movieDetail;
      final result = await saveWatchlist.execute(movieDetail);

      result.fold(
        (l) => emit(MovieWatchlistError(l.message)),
        (r) => emit(MovieAddWatchlistHasData(r)),
      );
    });
    on<OnRemoveMovieWatchlistEvent>((event, emit) async {
      emit(MovieWatchlistLoading());
      final movieDetail = event.movieDetail;
      final result = await removeWatchlist.execute(movieDetail);
      result.fold(
            (l) => emit(MovieWatchlistError(l.message)),
            (r) => emit(MovieAddWatchlistHasData(r)),
      );
    });
    on<OnGetMovieWatchlistEvent>((event, emit) async {
      emit(MovieWatchlistLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
            (l) => emit(MovieWatchlistError(l.message)),
            (r) => emit(MovieGetWatchlistHasData(r)),
      );
    });
  }
}
