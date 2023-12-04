
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain_tv/usecases/get_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

import '../../../domain_tv/entities/tv.dart';
import '../../../domain_tv/entities/tv_detail.dart';
import '../../../domain_tv/usecases/get_watchlist_status.dart';
import '../../../domain_tv/usecases/remove_watchlist.dart';
import '../../../domain_tv/usecases/save_watchlist.dart';

part 'tv_watchlist_event.dart';

part 'tv_watchlist_state.dart';

class TvWatchlistBloc
    extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistTv getWatchlistTvs;

  TvWatchlistBloc(
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
    this.getWatchlistTvs,
  ) : super(TvWatchlistInitial()) {
    on<OnStatusTvWatchlistEvent>((event, emit) async {
      emit(TvWatchlistLoading());
      final id = event.id;
      final result = await getWatchListStatus.execute(id);
      emit(TvStatusWatchlistHasData(result));
    });
    on<OnAddTvWatchlistEvent>((event, emit) async {
      emit(TvWatchlistLoading());
      final tvDetail = event.tvDetail;
      final result = await saveWatchlist.execute(tvDetail);

      result.fold(
        (l) => emit(TvWatchlistError(l.message)),
        (r) => emit(TvAddWatchlistHasData(r)),
      );
    });
    on<OnRemoveTvWatchlistEvent>((event, emit) async {
      emit(TvWatchlistLoading());
      final tvDetail = event.tvDetail;
      final result = await removeWatchlist.execute(tvDetail);
      result.fold(
            (l) => emit(TvWatchlistError(l.message)),
            (r) => emit(TvAddWatchlistHasData(r)),
      );
    });
    on<OnGetTvWatchlistEvent>((event, emit) async {
      emit(TvWatchlistLoading());
      final result = await getWatchlistTvs.execute();
      result.fold(
            (l) => emit(TvWatchlistError(l.message)),
            (r) => emit(TvGetWatchlistHasData(r)),
      );
    });
  }
}
