import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/entities/tv_series_entities/tv_series.dart';

class MockSearchBlocTVSeries extends MockBloc<SearchEvent, SearchState>
    implements SearchBlocTVSeries {}

class MockSearchEvent extends Fake implements SearchEvent {}

class MockSearchState extends Fake implements SearchState {}

void main() {
  late MockSearchBlocTVSeries mockSearchBlocTVSeries;

  setUpAll(() {
    registerFallbackValue(MockSearchEvent());
    registerFallbackValue(MockSearchState());
  });
  setUp(() {
    mockSearchBlocTVSeries = MockSearchBlocTVSeries();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchBlocTVSeries>(
      create: (context) => mockSearchBlocTVSeries,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    mockSearchBlocTVSeries.close();
  });

  final tTVSeriesModel = TVSeries(
    backdropPath: '/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg',
    genreIds: const [10759, 9648, 18],
    id: 93405,
    originalName: '오징어 게임',
    overview:
        'Hundreds of cash-strapped players accept a strange invitation to compete in children\'s games—with high stakes. But, a tempting prize awaits the victor.',
    popularity: 5200.044,
    posterPath: '/dDlEmu3EZ0Pgg93K2SVNLCjCSvE.jpg',
    originalLanguage: 'ko',
    name: 'Squid Game',
    originCountry: const ['KR'],
    voteAverage: 7.8,
    voteCount: 7842,
  );
  final tTVSeriesList = <TVSeries>[tTVSeriesModel];

  testWidgets(
      'Page should display [Loading, ListView] when data is gotten successfully',
      (WidgetTester tester) async {
    when(() => mockSearchBlocTVSeries.state).thenReturn(SearchLoading());
    when(() => mockSearchBlocTVSeries.add(const OnQueryChanged('squid game')))
        // ignore: void_checks
        .thenReturn((_) async => {});
    when(() => mockSearchBlocTVSeries.state)
        .thenReturn(SearchHasDataTVSeries(tTVSeriesList));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TVSeriesSearchPage()));
    await tester.pump();

    expect(progressBarFinder, findsOneWidget);
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchBlocTVSeries.state)
        .thenReturn(const SearchError('Server Failure'));

    final textFinder = find.text('Server Failure');

    await tester.pumpWidget(_makeTestableWidget(const TVSeriesSearchPage()));
    await tester.pumpAndSettle();

    expect(textFinder, findsOneWidget);
  });
}
