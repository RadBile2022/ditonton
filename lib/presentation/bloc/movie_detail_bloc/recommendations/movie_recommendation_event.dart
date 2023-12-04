part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();
  @override
  List<Object> get props => [];
}

class OnMovieRecommendationFetch extends MovieRecommendationEvent{
  final int id;

  OnMovieRecommendationFetch({required this.id});

  @override
  List<Object> get props =>[id];
}
