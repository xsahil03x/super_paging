import 'package:flutter_test/flutter_test.dart';
import 'package:super_pager/src/load_state.dart';

void main() {
  group('LoadState', () {
    test('NotLoading initializes correctly with endOfPaginationReached = true',
        () {
      var loadState = const LoadState.notLoading(endOfPaginationReached: true);

      expect(loadState, isA<NotLoading>());

      loadState = loadState as NotLoading;
      expect(loadState.endOfPaginationReached, true);
    });

    test('NotLoading initializes correctly with endOfPaginationReached = false',
        () {
      var loadState = const LoadState.notLoading(endOfPaginationReached: false);

      expect(loadState, isA<NotLoading>());

      loadState = loadState as NotLoading;
      expect(loadState.endOfPaginationReached, false);
    });

    test('notLoadingComplete is correctly initialized', () {
      const loadState = LoadState.notLoadingComplete;

      expect(loadState, isA<NotLoading>());
      expect(loadState.endOfPaginationReached, true);
    });

    test('notLoadingIncomplete is correctly initialized', () {
      const loadState = LoadState.notLoadingIncomplete;

      expect(loadState, isA<NotLoading>());
      expect(loadState.endOfPaginationReached, false);
    });

    test('Loading initializes correctly', () {
      const loadState = LoadState.loading();

      expect(loadState, isA<Loading>());
    });

    test('Error initializes correctly with an error', () {
      var loadState = LoadState.error(Exception('An error occurred'));

      expect(loadState, isA<Error>());

      loadState = loadState as Error;
      expect(loadState.error, isA<Exception>());
    });

    test('Error initializes correctly without an error', () {
      var loadState = const LoadState.error();

      expect(loadState, isA<Error>());

      loadState = loadState as Error;
      expect(loadState.error, isNull);
    });

    test(
        'NotLoading with endOfPaginationReached = true is correctly initialized',
        () {
      var loadState = const LoadState.notLoading(endOfPaginationReached: true);

      expect(loadState, isA<NotLoading>());

      loadState = loadState as NotLoading;
      expect(loadState.endOfPaginationReached, true);
    });

    test(
        'NotLoading with endOfPaginationReached = false is correctly initialized',
        () {
      var loadState = const LoadState.notLoading(endOfPaginationReached: false);

      expect(loadState, isA<NotLoading>());

      loadState = loadState as NotLoading;
      expect(loadState.endOfPaginationReached, false);
    });
  });
}
