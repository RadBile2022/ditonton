import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_movie_recommendations.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {

  final GetMovieRecommendations _getMovieRecommendations;
  MovieRecommendationBloc(this._getMovieRecommendations) : super(MovieRecommendationInitial()) {
    on<OnMovieRecommendationFetch>((event, emit) async {
      final id = event.id;
      emit(MovieRecommendationLoading());

      final result = await _getMovieRecommendations.execute(id);
      print("Hallo Kakak");
      print(result);
      result.fold(
            (l) => emit(MovieRecommendationError(l.message)),
            (r) => emit(MovieRecommendationHasData(r)),
      );
    });
  }
}
