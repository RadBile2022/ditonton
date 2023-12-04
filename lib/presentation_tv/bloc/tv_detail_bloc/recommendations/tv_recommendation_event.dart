part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationEvent extends Equatable {
  const TvRecommendationEvent();
  @override
  List<Object> get props => [];
}

class OnTvRecommendationFetch extends TvRecommendationEvent{
  final int id;

  OnTvRecommendationFetch({required this.id});

  @override
  List<Object> get props =>[id];
}
