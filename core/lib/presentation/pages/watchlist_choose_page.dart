import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class WatchlistChoosePage extends StatelessWidget {
  const WatchlistChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Watchlist'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 27,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_MOVIE_ROUTE);
              },
              child: Row(
                children: [
                  const Icon(Icons.arrow_forward_ios),
                  const SizedBox(
                    width: 15,
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Text(
                      'Movie Watchlist',
                      style: kHeading6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_TV_SERIES);
              },
              child: Row(
                children: [
                  const Icon(Icons.arrow_forward_ios),
                  const SizedBox(
                    width: 15,
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Text(
                      'TV Series Watchlist',
                      style: kHeading6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
