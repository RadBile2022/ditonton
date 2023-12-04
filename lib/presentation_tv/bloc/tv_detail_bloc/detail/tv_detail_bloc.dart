
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain_tv/entities/tv_detail.dart';
import '../../../../domain_tv/usecases/get_watchlist_status.dart';
import '../../../../domain_tv/usecases/get_tv_detail.dart';
import '../../../../domain_tv/usecases/get_tv_recommendations.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail detailResult;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatus getWatchListStatus;

  TvDetailBloc({
    required this.detailResult,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
  }) : super(TvDetailInitial()) {
    on<OnGetTvDetailFetch>((event, emit) async {
      emit(TvDetailLoading());
      final id = event.id;
      final tv = await detailResult.execute(id);
      tv.fold(
        (l) => emit(TvDetailError(l.message)),
        (r) => emit(TvDetailHasData(r)),
      );
    });
  }
}
