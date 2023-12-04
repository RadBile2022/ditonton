part of 'movie_search_cubit.dart';

abstract class MovieCubitSearchState extends Equatable {
  const MovieCubitSearchState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends MovieCubitSearchState {}

class SearchLoading extends MovieCubitSearchState {}

class SearchError extends MovieCubitSearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends MovieCubitSearchState {
  final List<Movie> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}