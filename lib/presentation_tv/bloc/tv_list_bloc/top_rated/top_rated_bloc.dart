import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain_tv/entities/tv.dart';
import '../../../../domain_tv/usecases/get_top_rated_movies.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedEvent, TopRatedState> {

  final GetTopRatedTv getTopRatedTvs;

  TopRatedTvBloc({required this.getTopRatedTvs})
      : super(TopRatedListEmpty()) {
    on<OnGetTopRatedTvFetch>((event, emit) async {
      emit(TopRatedListLoading());
      final result = await getTopRatedTvs.execute();
      result.fold(
            (l) => emit(TopRatedListError(l.message)),
            (r) => emit(TopRatedListHasData(r)),
      );
    });
  }
}