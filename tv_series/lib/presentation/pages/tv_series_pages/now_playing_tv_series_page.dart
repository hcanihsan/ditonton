import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingTVSeriesPage extends StatefulWidget {
  const NowPlayingTVSeriesPage({Key? key}) : super(key: key);

  @override
  _PopularTVSeriesPageState createState() => _PopularTVSeriesPageState();
}

class _PopularTVSeriesPageState extends State<NowPlayingTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<NowPlayingTVSeriesBloc>()
        .add(NowPlayingTVSeriesHasDataEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTVSeriesBloc, NowPlayingTVSeriesState>(
            builder: (context, state) {
          if (state is NowPlayingTVSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NowPlayingTVSeriesHasData) {
            final result = state.result;
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = result[index];
                return TVSeriesCard(movie);
              },
              itemCount: result.length,
            );
          } else if (state is NowPlayingTVSeriesError) {
            return Text(state.message);
          } else if (state is NowPlayingTVSeriesEmpty) {
            return const Text('Data Not Found');
          } else {
            return const Text('');
          }
        }),
      ),
    );
  }
}
