import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation_tv/bloc/tv_detail_bloc/detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation_tv/bloc/tv_detail_bloc/recommendations/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation_tv/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../domain_tv/entities/genre.dart';
import '../../domain_tv/entities/tv.dart';
import '../../domain_tv/entities/tv_detail.dart';
import '../bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   Provider.of<TvDetailNotifier>(context, listen: false)
    //       .fetchMovieDetail(widget.id);
    //   Provider.of<TvDetailNotifier>(context, listen: false)
    //       .loadWatchlistStatus(widget.id);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final movie = state.tvDetail;
            return SafeArea(
              child: DetailContent(
                movie,

              ),
            );
          } else {
            return Text("Failed");
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail movie;


  DetailContent(this.movie);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            BlocBuilder<TvWatchlistBloc,
                                TvWatchlistState>(
                              builder: (context, state) {
                                if (state is TvStatusWatchlistHasData) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (state.isAdded == true) {
                                        context.read<TvWatchlistBloc>().add(
                                            OnRemoveTvWatchlistEvent(movie));
                                        context.read<TvWatchlistBloc>().add(
                                            OnStatusTvWatchlistEvent(
                                                movie.id));
                                      } else {
                                        context.read<TvWatchlistBloc>().add(
                                            OnAddTvWatchlistEvent(movie));
                                        context.read<TvWatchlistBloc>().add(
                                            OnStatusTvWatchlistEvent(
                                                movie.id));

                                        // await Provider.of<MovieDetailNotifier>(
                                        //         context,
                                        //         listen: false)
                                        //     .addWatchlist(movie);
                                      }

                                      // final message =
                                      //     Provider.of<MovieDetailNotifier>(
                                      //             context,
                                      //             listen: false)
                                      //         .watchlistMessage;
                                      const watchlistAddSuccessMessage = 'Added to Watchlist';
                                      const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
                                      if (state.isAdded == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            content: Text(watchlistRemoveSuccessMessage)));
                                      }
                                      else if (state.isAdded == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            content: Text(watchlistAddSuccessMessage)));
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    "Message Snackbar belum jalan"),
                                              );
                                            });
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        state.isAdded == true
                                            ? Icon(Icons.check)
                                            : Icon(Icons.add),
                                        Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Text('Error');
                                }
                              },
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecommendationBloc,TvRecommendationState>(
                              builder: (context, state) {
                                if (state is TvRecommendationLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvRecommendationError) {
                                  return Text(state.message);
                                } else if (state is TvRecommendationHasData) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.Tvs[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {

                                              context
                                                  .read<TvDetailBloc>()
                                                  .add(OnGetTvDetailFetch(
                                                  id: movie.id));
                                              context
                                                  .read<
                                                  TvRecommendationBloc>()
                                                  .add(
                                                  OnTvRecommendationFetch(
                                                      id: movie.id));
                                              context
                                                  .read<
                                                  TvWatchlistBloc>()
                                                  .add(
                                                  OnStatusTvWatchlistEvent(
                                                       movie.id));

                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.Tvs.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
