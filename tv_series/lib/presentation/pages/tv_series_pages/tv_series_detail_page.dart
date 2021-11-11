import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TVSeriesDetailPage extends StatefulWidget {
  final int id;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  TVSeriesDetailPage({required this.id});

  @override
  _TVSeriesDetailPageState createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<DetailTVSeriesBloc>()
          .add(DetailTVSeriesHasDataEvent(widget.id));
      context
          .read<WatchlistTVSeriesBloc>()
          .add(LoadWatchlistStatusHasDataEvent(widget.id));
      context
          .read<RecommendationTVSeriesBloc>()
          .add(RecommendationTVSeriesHasDataEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    DetailTVSeriesState detailTVSeriesState =
        context.watch<DetailTVSeriesBloc>().state;
    RecommendationTVSeriesState recommendationTVSeriesState =
        context.watch<RecommendationTVSeriesBloc>().state;

    bool isAddToWatchListTVSeries = context.select<WatchlistTVSeriesBloc, bool>(
        (value) => (value.state is WatchlistStatusTVSeriesChanged)
            ? (value.state as WatchlistStatusTVSeriesChanged).status
            : (value.state is WatchlistStatusTVSeriesChanged)
                ? false
                : true);
    return Scaffold(
      body: SizedBox(
        child: detailTVSeriesState is DetailTVSeriesLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (detailTVSeriesState is DetailTVSeriesHasData)
                ? TVSeriesDetailContent(
                    detailTVSeriesState.result,
                    recommendationTVSeriesState is RecommendationTVSeriesHasData
                        ? recommendationTVSeriesState.result
                        : List.empty(),
                    isAddToWatchListTVSeries,
                  )
                : detailTVSeriesState is DetailTVSeriesError
                    ? Center(
                        child: Text(detailTVSeriesState.message),
                      )
                    : const Center(
                        child: Text('Data Not Found'),
                      ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TVSeriesDetailContent extends StatefulWidget {
  final TVSeriesDetail tvSeries;
  final List<TVSeries> recommendations;
  bool isAddedWatchlist;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  TVSeriesDetailContent(
      this.tvSeries, this.recommendations, this.isAddedWatchlist);

  @override
  State<TVSeriesDetailContent> createState() => _TVSeriesDetailContentState();
}

class _TVSeriesDetailContentState extends State<TVSeriesDetailContent> {
  final messageWatchlistAddSuccess = 'Added to Watchlist';
  final messageWatchlistRemoveSuccess = 'Removed from Watchlist';
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.tvSeries.posterPath}',
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
                              widget.tvSeries.name!,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  context.read<WatchlistTVSeriesBloc>().add(
                                      AddWatchlistTVSeriesHasDataEvent(
                                          widget.tvSeries));
                                } else {
                                  context.read<WatchlistTVSeriesBloc>().add(
                                      RemoveWatchlistTVSeriesHasDataEvent(
                                          widget.tvSeries));
                                }

                                final message = context.select<
                                    WatchlistTVSeriesBloc,
                                    String>((value) => (value.state
                                        is WatchlistStatusTVSeriesChanged)
                                    ? (value.state as WatchlistStatusTVSeriesChanged)
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
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Text(
                                _showGenres(widget.tvSeries.genres),
                              ),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvSeries.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvSeries.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvSeries.overview!,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTVSeriesBloc,
                                    RecommendationTVSeriesState>(
                                builder: (context, state) {
                              if (state is RecommendationTVSeriesLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state
                                  is RecommendationTVSeriesHasData) {
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
                                              TV_SERIES_DETAIL_ROUTE,
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
                              } else if (state is RecommendationTVSeriesError) {
                                return Text(state.message);
                              } else if (state is RecommendationTVSeriesEmpty) {
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
}
