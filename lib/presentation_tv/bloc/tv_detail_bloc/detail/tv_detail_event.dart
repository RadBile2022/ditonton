part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();
  @override
  List<Object> get props => [];
}

class OnGetTvDetailFetch extends TvDetailEvent {
  final int id;

  const OnGetTvDetailFetch({required this.id});
  @override

  List<Object> get props => [id];
}


