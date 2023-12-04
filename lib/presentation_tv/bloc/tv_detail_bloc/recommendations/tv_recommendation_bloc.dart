import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain_tv/entities/tv.dart';
import '../../../../domain_tv/usecases/get_tv_recommendations.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';

class TvRecommendationBloc extends Bloc<TvRecommendationEvent, TvRecommendationState> {

  final GetTvRecommendations _getTvRecommendations;
  TvRecommendationBloc(this._getTvRecommendations) : super(TvRecommendationInitial()) {
    on<OnTvRecommendationFetch>((event, emit) async {
      final id = event.id;
      emit(TvRecommendationLoading());

      final result = await _getTvRecommendations.execute(id);
      print("Hallo Kakak");
      print(result);
      result.fold(
            (l) => emit(TvRecommendationError(l.message)),
            (r) => emit(TvRecommendationHasData(r)),
      );
    });
  }
}
