// ignore_for_file: use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:movie/domain/entities/movie_entities/movie_detail.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movies_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  // ignore: prefer_const_constructors_in_immutables
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailMoviesBloc>().add(DetailMoviesHasDataEvent(widget.id));
      context
          .read<WatchlistMoviesBloc>()
          .add(LoadWatchlistStatusHasDataEvent(widget.id));
      context
          .read<RecommendationMoviesBloc>()
          .add(RecommendationMoviesHasDataEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    DetailMoviesState detailMoviesState =
        context.watch<DetailMoviesBloc>().state;
    RecommendationMoviesState recommendationMoviesState =
        context.watch<RecommendationMoviesBloc>().state;
    bool isAddToWatchListMovies = context.select<WatchlistMoviesBloc, bool>(
        (value) => (value.state is WatchlistStatusMoviesChanged)
            ? (value.state as WatchlistStatusMoviesChanged).status
            : (value.state is WatchlistStatusMoviesChanged)
                ? false
                : true);
    return WillPopScope(
      onWillPop: () async {
        context.read<WatchlistMoviesBloc>().add(WatchlistMoviesHasDataEvent());
        return true;
      },
      child: Scaffold(
        body: SizedBox(
          child: detailMoviesState is DetailMoviesLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (detailMoviesState is DetailMoviesHasData)
                  ? DetailContent(
                      detailMoviesState.result,
                      recommendationMoviesState is RecommendationMoviesHasData
                          ? recommendationMoviesState.result
                          : List.empty(),
                      isAddToWatchListMovies,
                    )
                  : detailMoviesState is DetailMoviesError
                      ? Center(
                          child: Text(detailMoviesState.message),
                        )
                      : const Center(
                          child: Text('Data Not Found'),
                        ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailContent extends StatefulWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  bool isAddedWatchlist;

  DetailContent(this.movie, this.recommendations, this.isAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  final messageWatchlistAddSuccess = 'Added to Watchlist';
  final messageWatchlistRemoveSuccess = 'Removed from Watchlist';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
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
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!widget.isAddedWatchlist) {
                                  context.read<WatchlistMoviesBloc>().add(
                                      AddWatchlistMoviesHasDataEvent(
                                          widget.movie));
                                } else {
                                  context.read<WatchlistMoviesBloc>().add(
                                      RemoveWatchlistMoviesHasDataEvent(
                                          widget.movie));
                                }

                                final message = context.select<
                                    WatchlistMoviesBloc,
                                    String>((value) => (value.state
                                        is WatchlistStatusMoviesChanged)
                                    ? (value.state as WatchlistStatusMoviesChanged)
                                                .status ==
                                            false
                                        ? messageWatchlistAddSuccess
                                        : messageWatchlistRemoveSuccess
                                    : !widget.isAddedWatchlist
                                        ? messageWatchlistAddSuccess
                                        : messageWatchlistRemoveSuccess);

                                if (message == messageWatchlistAddSuccess ||
                                    message == messageWatchlistRemoveSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                                setState(() {
                                  widget.isAddedWatchlist =
                                      !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationMoviesBloc,
                                    RecommendationMoviesState>(
                                builder: (context, state) {
                              if (state is RecommendationMoviesLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is RecommendationMoviesHasData) {
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final result = state.result[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              MOVIE_DETAIL_ROUTE,
                                              arguments: result.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${result.posterPath}',
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: widget.recommendations.length,
                                  ),
                                );
                              } else if (state is RecommendationMoviesError) {
                                return Text(state.message);
                              } else if (state is RecommendationMoviesEmpty) {
                                return const Text('Data Not Found');
                              } else {
                                return const Text('');
                              }
                            }),
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
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context
                    .read<WatchlistMoviesBloc>()
                    .add(WatchlistMoviesHasDataEvent());
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
