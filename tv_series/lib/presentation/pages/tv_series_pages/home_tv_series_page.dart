import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class HomeTVSeriesPage extends StatefulWidget {
  const HomeTVSeriesPage({Key? key}) : super(key: key);

  @override
  _HomeTVSeriesPageState createState() => _HomeTVSeriesPageState();
}

class _HomeTVSeriesPageState extends State<HomeTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<NowPlayingTVSeriesBloc>()
          .add(NowPlayingTVSeriesHasDataEvent());
      context.read<PopularTVSeriesBloc>().add(PopularTVSeriesHasDataEvent());
      context.read<TopRatedTVSeriesBloc>().add(TopRatedTVSeriesHasDataEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('TV Series')),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 27,
            )),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_SERIES_ROUTE);
            },
            icon: const Icon(Icons.search),
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
                    Navigator.pushNamed(context, NOW_PLAYING_TV_SERIES_ROUTE),
              ),
              BlocBuilder<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
                  builder: (context, state) {
                if (state is NowPlayingTVSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingTVSeriesHasData) {
                  final result = state.result;
                  return TVSeriesList(result);
                } else if (state is NowPlayingTVSeriesError) {
                  return Text(state.message);
                } else if (state is NowPlayingTVSeriesEmpty) {
                  return const Text('Data Not Found');
                } else {
                  return const Text('');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, POPULAR_TV_SERIES_ROUTE),
              ),
              BlocBuilder<PopularTVSeriesBloc, PopularTVSeriesState>(
                  builder: (context, state) {
                if (state is PopularTVSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTVSeriesHasData) {
                  final result = state.result;
                  return TVSeriesList(result);
                } else if (state is PopularTVSeriesError) {
                  return Text(state.message);
                } else if (state is PopularTVSeriesEmpty) {
                  return const Text('Data Not Found');
                } else {
                  return const Text('');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TOP_RATED_TV_SERIES_ROUTE),
              ),
              BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
                  builder: (context, state) {
                if (state is TopRatedTVSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTVSeriesHasData) {
                  final result = state.result;
                  return TVSeriesList(result);
                } else if (state is TopRatedTVSeriesError) {
                  return Text(state.message);
                } else if (state is TopRatedTVSeriesEmpty) {
                  return const Text('Data Not Found');
                } else {
                  return const Text('');
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
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeries;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  TVSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final seriesTV = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_SERIES_DETAIL_ROUTE,
                  arguments: seriesTV.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${seriesTV.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
