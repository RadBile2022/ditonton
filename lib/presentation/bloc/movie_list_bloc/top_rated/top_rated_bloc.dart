import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_top_rated_movies.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {

  final GetTopRatedMovies getTopRatedMovies;

  TopRatedBloc({required this.getTopRatedMovies})
      : super(TopRatedListEmpty()) {
    on<OnGetTopRatedMoviesFetch>((event, emit) async {
      emit(TopRatedListLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
            (l) => emit(TopRatedListError(l.message)),
            (r) => emit(TopRatedListHasData(r)),
      );
    });
  }
}