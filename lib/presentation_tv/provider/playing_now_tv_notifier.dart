import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain_tv/usecases/get_now_playing_tv.dart';
import 'package:ditonton/domain_tv/usecases/get_popular_tv.dart';
import 'package:flutter/foundation.dart';

import '../../domain_tv/entities/tv.dart';

class PlayingNowTvNotifier extends ChangeNotifier {
  final GetNowPlayingTv getPopularMovies;

  PlayingNowTvNotifier(this.getPopularMovies);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _movies = [];
  List<Tv> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchPlayingNowMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
