import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTVSeriesPage extends StatefulWidget {
  const WatchlistTVSeriesPage({Key? key}) : super(key: key);

  @override
  _WatchlistTVSeriesPageState createState() => _WatchlistTVSeriesPageState();
}

class _WatchlistTVSeriesPageState extends State<WatchlistTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<WatchlistTVSeriesBloc>()
        .add(WatchlistTVSeriesHasDataEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTVSeriesBloc, WatchlistTVSeriesState>(
            builder: (context, state) {
          if (state is WatchlistTVSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTVSeriesHasData) {
            final result = state.result;
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = result[index];
                return TVSeriesCard(movie);
              },
              itemCount: result.length,
            );
          } else if (state is WatchlistTVSeriesError) {
            return Text(state.message);
          } else if (state is WatchlistTVSeriesEmpty) {
            return const Text('Data Not Found');
          } else {
            return const Text('');
          }
        }),
      ),
    );
  }
}
