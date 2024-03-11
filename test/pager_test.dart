import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:super_paging/super_paging.dart';

import 'fake_paging_source.dart';

const initialState = PagingState<int, String>(
  pages: PagingList(bottom: [
    LoadResultPage(items: ['Item 1', 'Item 2'], prevKey: null, nextKey: 2),
  ]),
  refreshLoadState: LoadState.notLoadingComplete,
  prependLoadState: LoadState.notLoadingComplete,
  appendLoadState: LoadState.notLoading(endOfPaginationReached: false),
);

void main() {
  test('Pager should be initialized with the provided initialState', () {
    // Test initialization with a custom initial state.
    final pager = Pager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSourceFactory: () => const FakePagingSource(),
      initialState: initialState,
    );

    expect(pager.value, equals(initialState));
  });

  test('Pager should load data with load method', () async {
    final pager = Pager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSourceFactory: () => const FakePagingSource(),
    );

    await pager.load(LoadType.refresh);

    // Assert that the value is not empty, indicating that data is loaded.
    expect(pager.value.pages, isNotEmpty);
  });

  test('Pager should refresh data with refresh method', () async {
    final pager = Pager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSourceFactory: () => const FakePagingSource(),
    );

    await pager.load(LoadType.refresh);
    await pager.load(LoadType.append);
    final previousValue = pager.value;

    await pager.refresh();

    // Assert that the value has changed after refresh.
    expect(pager.value, isNot(equals(previousValue)));
  });

  test('Pager should correctly handle error states', () async {
    final errorPagingSource = ErrorPagingSource(); // Simulated error source
    final pager = Pager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSourceFactory: () => errorPagingSource,
    );

    await pager.load(LoadType.refresh);

    // Assert that the value contains an error state.
    expect(pager.value.refreshLoadState is Error, isTrue);
  });

  test('Pager should retry failed load requests', () async {
    final errorPagingSource = ErrorPagingSource(); // Simulated error source
    final pager = Pager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSourceFactory: () => errorPagingSource,
    );

    await pager.load(LoadType.refresh);
    final previousValue = pager.value;

    await pager.retry();

    // Assert that the value has changed after the retry.
    expect(pager.value, isNot(equals(previousValue)));
  });

  test('Pager should add and remove listeners correctly', () async {
    final pager = Pager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSourceFactory: () => const FakePagingSource(),
    );

    int listenerCount = 0;

    void listener() {
      listenerCount++;
    }

    // Add listener and ensure it's triggered.
    pager.addListener(listener);
    await pager.load(LoadType.refresh);

    expect(listenerCount, greaterThan(0));

    // Remove listener and ensure it's not triggered.
    final previousListenerCount = listenerCount;
    pager.removeListener(listener);
    await pager.load(LoadType.append);

    expect(listenerCount, equals(previousListenerCount));
  });

  test('Pager should dispose correctly', () {
    final pager = Pager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSourceFactory: () => const FakePagingSource(),
    );

    pager.dispose();

    // Adding a listener after disposal should throw an error.
    expect(() => pager.addListener(() {}), throwsA(isA<FlutterError>()));
  });

  test('Pager should handle multiple pages correctly', () async {
    final pager = Pager<int, String>(
      config: const PagingConfig(pageSize: 20),
      // Ensure multiple pages
      pagingSourceFactory: () => const FakePagingSource(),
    );

    await pager.load(LoadType.refresh);

    // Verify that the first page is loaded.
    expect(pager.value.pages.items, hasLength(60));

    // Load more data (next page).
    await pager.load(LoadType.append);

    // Verify that the second page is loaded.
    expect(pager.value.pages.items, hasLength(80));
  });

  test('Pager should correctly handle resetting pages during refresh',
      () async {
    final pager = Pager<int, String>(
      config: const PagingConfig(pageSize: 20),
      // Ensure multiple pages
      pagingSourceFactory: () => const FakePagingSource(),
    );

    await pager.load(LoadType.refresh);
    await pager.load(LoadType.append);

    // Verify that the items is loaded.
    expect(pager.value.pages.items, hasLength(80));

    // Refresh data with resetting pages.
    await pager.refresh(resetPages: true);

    // Verify that the data is refreshed and pages are reset.
    expect(pager.value.pages.items, hasLength(60));
  });

  test('Pager should correctly handle concurrency', () async {
    final pager = Pager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSourceFactory: () => const FakePagingSource(),
    );

    // Initial load.
    await pager.load(LoadType.refresh);

    // Concurrent load requests.
    final loadFuture1 = pager.load(LoadType.prepend);
    final loadFuture2 = pager.load(LoadType.append);

    // Ensure concurrent load requests do not interfere with each other.
    await Future.wait([loadFuture1, loadFuture2]);
  });

  group('SuperPagerExtension', () {
    late Pager<int, String> pager;

    setUp(() {
      pager = Pager<int, String>(
        config: const PagingConfig(pageSize: 20),
        pagingSourceFactory: () => const FakePagingSource(),
        initialState: initialState,
      );
    });

    test('items should return all loaded items', () {
      final loadedItems = pager.items;
      expect(loadedItems.length, equals(2));
    });

    test('pages should return a list with all loaded pages', () {
      final loadedPages = pager.pages;
      expect(loadedPages.length, equals(1));
    });

    test(
      'refreshLoadState should return the load state of the initial page',
      () {
        final loadState = pager.refreshLoadState;
        expect(loadState, equals(LoadState.notLoadingComplete));
        // Add more assertions based on your specific use case
      },
    );

    test('prependLoadState should return the load state of the previous page',
        () {
      final loadState = pager.prependLoadState;
      expect(loadState, equals(LoadState.notLoadingComplete));
    });

    test('appendLoadState should return the load state of the next page', () {
      final LoadState loadState = pager.appendLoadState;
      expect(
        loadState,
        equals(const LoadState.notLoading(endOfPaginationReached: false)),
      );
    });
  });
}
