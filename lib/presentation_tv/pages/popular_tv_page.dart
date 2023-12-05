import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation_tv/bloc/tv_list_bloc/popular/popular_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../widgets/card_list.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<PopularTvNotifier>(context, listen: false)
    //         .fetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, PopularState>(
          builder: (context, state) {
            if (state is PopularListLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularListHasData) {
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
