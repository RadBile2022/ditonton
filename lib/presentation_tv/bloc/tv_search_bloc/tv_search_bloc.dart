import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain_tv/entities/tv.dart';
import '../../../domain_tv/usecases/search_movies.dart';


part 'tv_search_event.dart';

part 'tv_search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv _searchTvs;

  TvSearchBloc(this._searchTvs) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      emit(SearchLoading());
      final query = event.query;
      final result = await _searchTvs.execute(query);
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
