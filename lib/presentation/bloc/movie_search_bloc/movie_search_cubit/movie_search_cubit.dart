import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/search_movies.dart';


part 'movie_cubit_search_state.dart';


class MovieSearchCubit extends Cubit<MovieCubitSearchState>{
  final SearchMovies _searchMovies;

  MovieSearchCubit(this._searchMovies) : super(SearchEmpty());

  void onQueryChanged(String query)async{
    emit(SearchLoading());
    final result = await _searchMovies.execute(query);
    result.fold((l) => emit(SearchError(l.message)), (r) =>emit(SearchHasData(r)));
  }
}