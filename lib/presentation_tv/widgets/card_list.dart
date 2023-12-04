import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain_tv/entities/tv.dart';
import '../bloc/tv_detail_bloc/detail/tv_detail_bloc.dart';
import '../bloc/tv_detail_bloc/recommendations/tv_recommendation_bloc.dart';
import '../bloc/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import '../pages/tv_detail_page.dart';

class CardList extends StatelessWidget {
  final Tv movie;

  CardList(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
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
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      movie.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
