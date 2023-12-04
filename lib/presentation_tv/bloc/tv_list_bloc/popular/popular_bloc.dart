import 'package:ditonton/domain_tv/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain_tv/entities/tv.dart';


part 'popular_event.dart';
part 'popular_state.dart';

class PopularTvBloc extends Bloc<PopularEvent, PopularState> {

  final GetPopularTv getPopularTvs;
  //

  PopularTvBloc({required this.getPopularTvs})
      : super(PopularListEmpty()) {
    on<OnGetPopularTvFetch>((event, emit) async {
      emit(PopularListLoading());
      final result = await getPopularTvs.execute();
      result.fold(
            (l) => emit(PopularListError(l.message)),
            (r) => emit(PopularListHasData(r)),
      );
    });
  }
}