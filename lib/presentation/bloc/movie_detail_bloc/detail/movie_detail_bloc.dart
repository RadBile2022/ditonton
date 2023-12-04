import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/get_movie_recommendations.dart';
import '../../../../domain/usecases/get_watchlist_status.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail detailResult;

  MovieDetailBloc({
    required this.detailResult,
  }) : super(MovieDetailInitial()) {
    on<OnGetMovieDetailFetch>((event, emit) async {
      emit(MovieDetailLoading());
      final id = event.id;
      final movie = await detailResult.execute(id);
      movie.fold(
        (l) => emit(MovieDetailError(l.message)),
        (r) => emit(MovieDetailHasData(r)),
      );
    });
  }
}
