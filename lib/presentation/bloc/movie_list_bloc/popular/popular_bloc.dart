import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_popular_movies.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {

  final GetPopularMovies getPopularMovies;
  //

  PopularBloc({required this.getPopularMovies})
      : super(PopularListEmpty()) {
    on<OnGetPopularMoviesFetch>((event, emit) async {
      emit(PopularListLoading());
      final result = await getPopularMovies.execute();
      result.fold(
            (l) => emit(PopularListError(l.message)),
            (r) => emit(PopularListHasData(r)),
      );
    });
  }
}