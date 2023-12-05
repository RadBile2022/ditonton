import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation_tv/bloc/tv_list_bloc/now_playing/now_playing_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_list_bloc/popular/popular_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_list_bloc/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation_tv/pages/playing_now_tv_page.dart';
import 'package:ditonton/presentation_tv/pages/popular_tv_page.dart';
import 'package:ditonton/presentation_tv/pages/search_page.dart';
import 'package:ditonton/presentation_tv/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation_tv/pages/tv_detail_page.dart';
import 'package:ditonton/presentation_tv/pages/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../domain_tv/entities/tv.dart';
import '../bloc/tv_detail_bloc/detail/tv_detail_bloc.dart';
import '../bloc/tv_detail_bloc/recommendations/tv_recommendation_bloc.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv-page';

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
  /*  Future.microtask(
        () => Provider.of<TvListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageTv.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, PlayingNowTvPage.ROUTE_NAME),
              ),
              BlocBuilder<NowPlayingTvBloc, NowPlayingListState>(builder: (context, state) {
                if (state is NowPlayingListLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingListHasData) {
                  return MovieList(state.result);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc,PopularState>(builder: (context, state) {
                if (state is PopularListLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularListHasData) {
                  return MovieList(state.result);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc,TopRatedState>(builder: (context, state) {
                if (state is TopRatedListLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedListHasData) {
                  return MovieList(state.result);
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Tv> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                context.read<TvDetailBloc>().add(OnGetTvDetailFetch(id: movie.id));
                context.read<TvRecommendationBloc>().add(OnTvRecommendationFetch(id: movie.id));
                context.read<TvWatchlistBloc>().add(OnStatusTvWatchlistEvent(movie.id));
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
