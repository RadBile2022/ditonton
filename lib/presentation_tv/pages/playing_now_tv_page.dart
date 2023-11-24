import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation_tv/provider/playing_now_tv_notifier.dart';
import 'package:ditonton/presentation_tv/provider/popular_tv_notifier.dart';
import 'package:ditonton/presentation_tv/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
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
    Future.microtask(() =>
        Provider.of<PlayingNowTvNotifier>(context, listen: false)
            .fetchPlayingNowMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playing Now Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PlayingNowTvNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return CardList(movie);
                },
                itemCount: data.movies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
