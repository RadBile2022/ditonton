import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain_tv/entities/tv.dart';
import '../../../../domain_tv/usecases/get_now_playing_tv.dart';

part 'now_playing_event.dart';

part 'now_playing_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingEvent, NowPlayingListState> {
  final GetNowPlayingTv getNowPlayingTvs;

  NowPlayingTvBloc({required this.getNowPlayingTvs})
      : super(NowPlayingListEmpty()) {
    on<OnGetNowPlayingTvFetch>((event, emit) async {
      emit(NowPlayingListLoading());
      final result = await getNowPlayingTvs.execute();
      result.fold(
        (l) => emit(NowPlayingListError(l.message)),
        (r) => emit(NowPlayingListHasData(r)),
      );
    });
  }
}
