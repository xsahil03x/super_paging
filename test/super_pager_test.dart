import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:super_pager/super_pager.dart';

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
  test('SuperPager should be initialized with the provided initialState', () {
    // Test initialization with a custom initial state.
    final superPager = SuperPager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
      initialState: initialState,
    );

    expect(superPager.value, equals(initialState));
  });

  test('SuperPager should load data with load method', () async {
    final superPager = SuperPager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
    );

    await superPager.load(LoadType.refresh);

    // Assert that the value is not empty, indicating that data is loaded.
    expect(superPager.value.pages, isNotEmpty);
  });

  test('SuperPager should refresh data with refresh method', () async {
    final superPager = SuperPager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
    );

    await superPager.load(LoadType.refresh);
    await superPager.load(LoadType.append);
    final previousValue = superPager.value;

    await superPager.refresh();

    // Assert that the value has changed after refresh.
    expect(superPager.value, isNot(equals(previousValue)));
  });

  test('SuperPager should correctly handle error states', () async {
    final errorPagingSource = ErrorPagingSource(); // Simulated error source
    final superPager = SuperPager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: errorPagingSource,
    );

    await superPager.load(LoadType.refresh);

    // Assert that the value contains an error state.
    expect(superPager.value.refreshLoadState is Error, isTrue);
  });

  test('SuperPager should retry failed load requests', () async {
    final errorPagingSource = ErrorPagingSource(); // Simulated error source
    final superPager = SuperPager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: errorPagingSource,
    );

    await superPager.load(LoadType.refresh);
    final previousValue = superPager.value;

    await superPager.retry();

    // Assert that the value has changed after the retry.
    expect(superPager.value, isNot(equals(previousValue)));
  });

  test('SuperPager should add and remove listeners correctly', () async {
    final superPager = SuperPager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
    );

    int listenerCount = 0;

    void listener() {
      listenerCount++;
    }

    // Add listener and ensure it's triggered.
    superPager.addListener(listener);
    await superPager.load(LoadType.refresh);

    expect(listenerCount, greaterThan(0));

    // Remove listener and ensure it's not triggered.
    final previousListenerCount = listenerCount;
    superPager.removeListener(listener);
    await superPager.load(LoadType.append);

    expect(listenerCount, equals(previousListenerCount));
  });

  test('SuperPager should dispose correctly', () {
    final superPager = SuperPager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
    );

    superPager.dispose();

    // Adding a listener after disposal should throw an error.
    expect(() => superPager.addListener(() {}), throwsA(isA<FlutterError>()));
  });

  test('SuperPager should handle multiple pages correctly', () async {
    final superPager = SuperPager<int, String>(
      config: const PagingConfig(pageSize: 20),
      // Ensure multiple pages
      pagingSource: const FakePagingSource(),
    );

    await superPager.load(LoadType.refresh);

    // Verify that the first page is loaded.
    expect(superPager.value.pages.items, hasLength(60));

    // Load more data (next page).
    await superPager.load(LoadType.append);

    // Verify that the second page is loaded.
    expect(superPager.value.pages.items, hasLength(80));
  });

  test('SuperPager should correctly handle resetting pages during refresh',
      () async {
    final superPager = SuperPager<int, String>(
      config: const PagingConfig(pageSize: 20),
      // Ensure multiple pages
      pagingSource: const FakePagingSource(),
    );

    await superPager.load(LoadType.refresh);
    await superPager.load(LoadType.append);

    // Verify that the items is loaded.
    expect(superPager.value.pages.items, hasLength(80));

    // Refresh data with resetting pages.
    await superPager.refresh(resetPages: true);

    // Verify that the data is refreshed and pages are reset.
    expect(superPager.value.pages.items, hasLength(60));
  });

  test('SuperPager should correctly handle concurrency', () async {
    final superPager = SuperPager<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
    );

    // Initial load.
    await superPager.load(LoadType.refresh);

    // Concurrent load requests.
    final loadFuture1 = superPager.load(LoadType.prepend);
    final loadFuture2 = superPager.load(LoadType.append);

    // Ensure concurrent load requests do not interfere with each other.
    await Future.wait([loadFuture1, loadFuture2]);
  });
}
