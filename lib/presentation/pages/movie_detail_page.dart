import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc/recommendations/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatelessWidget {
  static const ROUTE_NAME = '/detail';

  final int id;

  MovieDetailPage({required this.id});

//   @override
//   _MovieDetailPageState createState() => _MovieDetailPageState();
// }
//
// class _MovieDetailPageState extends State<MovieDetailPage> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<MovieDetailNotifier>(context, listen: false)
//           .fetchMovieDetail(widget.id);
//       Provider.of<MovieDetailNotifier>(context, listen: false)
//           .loadWatchlistStatus(widget.id);
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            final movie = state.movieDetail;
            return SafeArea(
              child: DetailContent(
                movie,
              ),
            );
          } else {
            return Text("failed ");
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;

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
                            BlocBuilder<MovieWatchlistBloc,
                                MovieWatchlistState>(
                              builder: (context, state) {
                                if (state is MovieStatusWatchlistHasData) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (state.isAdded == true) {
                                        context.read<MovieWatchlistBloc>().add(
                                            OnRemoveMovieWatchlistEvent(movie));
                                        context.read<MovieWatchlistBloc>().add(
                                            OnStatusMovieWatchlistEvent(
                                                movie.id));
                                      } else {
                                        context.read<MovieWatchlistBloc>().add(
                                            OnAddMovieWatchlistEvent(movie));
                                        context.read<MovieWatchlistBloc>().add(
                                            OnStatusMovieWatchlistEvent(
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
                            BlocBuilder<MovieRecommendationBloc,
                                MovieRecommendationState>(
                              builder: (context, state) {
                                if (state is MovieRecommendationLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MovieRecommendationError) {
                                  return Text("Failed");
                                } else if (state
                                    is MovieRecommendationHasData) {
                                  print(state.movies);
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.movies[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              context
                                                  .read<MovieDetailBloc>()
                                                  .add(OnGetMovieDetailFetch(
                                                      id: movie.id));
                                              context
                                                  .read<
                                                      MovieRecommendationBloc>()
                                                  .add(
                                                      OnMovieRecommendationFetch(
                                                          id: movie.id));
                                              context
                                                  .read<
                                                  MovieWatchlistBloc>()
                                                  .add(
                                                  OnStatusMovieWatchlistEvent(
                                                      movie.id));
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
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
                                      itemCount: state.movies.length,
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
      result += genre.name + ', ';
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
