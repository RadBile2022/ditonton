part of 'top_rated_bloc.dart';

abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

class TopRatedListEmpty extends TopRatedState {}

class TopRatedListLoading extends TopRatedState {}

class TopRatedListError extends TopRatedState {
  final String message;

  TopRatedListError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedListHasData extends TopRatedState {
  final List<Movie> result;

  TopRatedListHasData(this.result);

  @override
  List<Object> get props => [result];
}
