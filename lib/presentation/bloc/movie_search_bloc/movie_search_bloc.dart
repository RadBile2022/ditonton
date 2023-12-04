import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/search_movies.dart';

part 'movie_search_event.dart';

part 'movie_search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies _searchMovies;

  MovieSearchBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      emit(SearchLoading());
      final query = event.query;
      final result = await _searchMovies.execute(query);
      result.fold(
        (l) => emit(SearchError(l.message)),
        (r) => emit(SearchHasData(r)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<OnUsernameChanged>((event, emit) {
      final username = event.username;
      emit(SearchLoading());

      emit(SearchError("salah"));
    });
  }
}
