import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTVSeriesPage extends StatefulWidget {
  const TopRatedTVSeriesPage({Key? key}) : super(key: key);

  @override
  _TopRatedTVSeriesPageState createState() => _TopRatedTVSeriesPageState();
}

class _TopRatedTVSeriesPageState extends State<TopRatedTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<TopRatedTVSeriesBloc>()
        .add(TopRatedTVSeriesHasDataEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
            builder: (context, state) {
          if (state is TopRatedTVSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedTVSeriesHasData) {
            final result = state.result;
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = result[index];
                return TVSeriesCard(movie);
              },
              itemCount: result.length,
            );
          } else if (state is TopRatedTVSeriesError) {
            return Text(state.message);
          } else if (state is TopRatedTVSeriesEmpty) {
            return const Text('Data Not Found');
          } else {
            return const Text('');
          }
        }),
      ),
    );
  }
}
