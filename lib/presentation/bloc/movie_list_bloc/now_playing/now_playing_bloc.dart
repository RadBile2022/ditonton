import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_now_playing_movies.dart';

part 'now_playing_event.dart';

part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingListState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingBloc({required this.getNowPlayingMovies})
      : super(NowPlayingListEmpty()) {
    on<OnGetNowPlayingMoviesFetch>((event, emit) async {
      emit(NowPlayingListLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (l) => emit(NowPlayingListError(l.message)),
        (r) => emit(NowPlayingListHasData(r)),
      );
    });
  }
}
