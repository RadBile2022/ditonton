part of 'movie_search_bloc.dart';
abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends MovieSearchEvent {
  final String query;

  OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class OnUsernameChanged extends MovieSearchEvent{
  final String username;

  OnUsernameChanged(this.username);
}

