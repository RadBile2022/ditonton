import 'package:ditonton/presentation/bloc/movie_list_bloc/popular/popular_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PopularMoviesPage extends StatelessWidget {

  static const ROUTE_NAME = '/popular-movie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularBloc,PopularState>(
          builder: (context, state) {
            if (state is PopularListLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularListHasData) {
              final movies = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCard(movie);
                },
                itemCount: movies.length,
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
