part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularListEmpty extends PopularState {}

class PopularListLoading extends PopularState {}

class PopularListError extends PopularState {
  final String message;

  PopularListError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularListHasData extends PopularState {
  final List<Movie> result;

  PopularListHasData(this.result);

  @override
  List<Object> get props => [result];
}
