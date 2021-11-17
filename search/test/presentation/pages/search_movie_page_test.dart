import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/movie_entities/movie.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchBlocMovie extends MockBloc<SearchEvent, SearchState>
    implements SearchBlocMovie {}

class MockSearchEvent extends Fake implements SearchEvent {}

class MockSearchState extends Fake implements SearchState {}

void main() {
  late MockSearchBlocMovie mockSearchMovies;

  setUpAll(() {
    registerFallbackValue(MockSearchEvent());
    registerFallbackValue(MockSearchState());
  });
  setUp(() {
    mockSearchMovies = MockSearchBlocMovie();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchBlocMovie>(
      create: (context) => mockSearchMovies,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockSearchMovies.close();
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  testWidgets(
      'Page should display [Loading, ListView] when data is gotten successfully',
      (WidgetTester tester) async {
    when(() => mockSearchMovies.state).thenReturn(SearchLoading());
    when(() => mockSearchMovies.add(const OnQueryChanged('spiderman')))
        // ignore: void_checks
        .thenReturn((_) async => {});
    when(() => mockSearchMovies.state)
        .thenReturn(SearchHasDataMovie(tMovieList));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const MovieSearchPage()));
    await tester.pump();

    expect(progressBarFinder, findsOneWidget);
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchMovies.state)
        .thenReturn(const SearchError('Server Failure'));

    final textFinder = find.text('Server Failure');

    await tester.pumpWidget(_makeTestableWidget(const MovieSearchPage()));
    await tester.pumpAndSettle();

    expect(textFinder, findsOneWidget);
  });
}
