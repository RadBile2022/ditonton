import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain_tv/usecases/get_popular_tv.dart';
import 'package:flutter/foundation.dart';

import '../../domain_tv/entities/tv.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetPopularTv getPopularMovies;

  PopularTvNotifier(this.getPopularMovies);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _movies = [];
  List<Tv> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularMovies() async {
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
