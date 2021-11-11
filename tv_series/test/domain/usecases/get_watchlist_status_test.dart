import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTVSeries usecaseTVSeries;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecaseTVSeries = GetWatchListStatusTVSeries(mockTVSeriesRepository);
  });

  test('should get watchlist status tv series from repository', () async {
    // arrange
    when(mockTVSeriesRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecaseTVSeries.execute(1);
    // assert
    expect(result, true);
  });
}
