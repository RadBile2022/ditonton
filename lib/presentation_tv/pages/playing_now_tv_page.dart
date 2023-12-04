import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation_tv/bloc/tv_list_bloc/now_playing/now_playing_bloc.dart';
import 'package:ditonton/presentation_tv/provider/playing_now_tv_notifier.dart';
import 'package:ditonton/presentation_tv/provider/popular_tv_notifier.dart';
import 'package:ditonton/presentation_tv/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../widgets/card_list.dart';

class PlayingNowTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/playing-now-tv';

  @override
  _PlayingNowTvPageState createState() => _PlayingNowTvPageState();
}

class _PlayingNowTvPageState extends State<PlayingNowTvPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<PlayingNowTvNotifier>(context, listen: false)
    //         .fetchPlayingNowMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playing Now Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvBloc, NowPlayingListState>(
          builder: (context, state) {
            if (state is NowPlayingListLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingListHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return CardList(movie);
                },
                itemCount: state.result.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text("Failed"),
              );
            }
          },
        ),
      ),
    );
  }
}
