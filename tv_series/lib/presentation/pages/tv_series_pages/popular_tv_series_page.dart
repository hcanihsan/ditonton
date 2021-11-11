import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTVSeriesPage extends StatefulWidget {
  const PopularTVSeriesPage({Key? key}) : super(key: key);

  @override
  _PopularTVSeriesPageState createState() => _PopularTVSeriesPageState();
}

class _PopularTVSeriesPageState extends State<PopularTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularTVSeriesBloc>().add(PopularTVSeriesHasDataEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVSeriesBloc, PopularTVSeriesState>(
            builder: (context, state) {
          if (state is PopularTVSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularTVSeriesHasData) {
            final result = state.result;
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = result[index];
                return TVSeriesCard(movie);
              },
              itemCount: result.length,
            );
          } else if (state is PopularTVSeriesError) {
            return Text(state.message);
          } else if (state is PopularTVSeriesEmpty) {
            return const Text('Data Not Found');
          } else {
            return const Text('');
          }
        }),
      ),
    );
  }
}
