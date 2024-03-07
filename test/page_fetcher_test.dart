import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_paging/src/page_fetcher.dart';
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
  test('PageFetcher should be initialized with the provided initialState', () {
    final pageFetcher = PageFetcher<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
      initialState: initialState,
    );

    expect(pageFetcher.value, equals(initialState));
  });

  test('PageFetcher should load data with load method', () async {
    final pageFetcher = PageFetcher<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
      initialState: const PagingState(),
    );

    await pageFetcher.load(LoadType.refresh);

    // Assert that the value is not empty, indicating that data is loaded.
    expect(pageFetcher.value.pages.items, isNotEmpty);
  });

  test('PageFetcher should correctly handle error states', () async {
    final errorPagingSource = ErrorPagingSource(); // Simulated error source
    final pageFetcher = PageFetcher<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: errorPagingSource,
      initialState: const PagingState(),
    );

    await pageFetcher.load(LoadType.refresh);

    // Assert that the value contains an error state.
    expect(pageFetcher.value.refreshLoadState is Error, isTrue);
  });

  test('PageFetcher should retry failed load requests', () async {
    final errorPagingSource = ErrorPagingSource(); // Simulated error source
    final pageFetcher = PageFetcher<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: errorPagingSource,
      initialState: const PagingState(),
    );

    await pageFetcher.load(LoadType.refresh);
    final previousValue = pageFetcher.value;

    await pageFetcher.retry();

    // Assert that the value has changed after the retry.
    expect(pageFetcher.value, isNot(equals(previousValue)));
  });

  test('PageFetcher should drop pages when necessary', () async {
    final pageFetcher = PageFetcher<int, String>(
      config: const PagingConfig(pageSize: 20, maxSize: 80),
      pagingSource: const FakePagingSource(),
      initialState: const PagingState(),
    );

    // Load data to exceed maxSize.
    await pageFetcher.load(LoadType.refresh);
    await pageFetcher.load(LoadType.append);
    await pageFetcher.load(LoadType.append);
    await pageFetcher.load(LoadType.append);
    await pageFetcher.load(LoadType.append);

    // Ensure pages are dropped to meet maxSize.
    expect(pageFetcher.value.pages.itemCount, equals(80));
  });

  test('PageFetcher should be disposed correctly', () {
    final pageFetcher = PageFetcher<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
      initialState: const PagingState(),
    );

    pageFetcher.dispose();

    // Adding a listener after disposal should throw an exception.
    expect(() => pageFetcher.addListener(() {}), throwsA(isA<FlutterError>()));
  });

  test('PageFetcher should handle loading multiple pages with append',
      () async {
    final pageFetcher = PageFetcher<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
      initialState: const PagingState(),
    );

    await pageFetcher.load(LoadType.refresh);
    final initialLoad = pageFetcher.value;

    await pageFetcher.load(LoadType.append);

    // Verify that pages are loaded and appended correctly.
    expect(pageFetcher.value.pages.itemCount, equals(80));
    expect(pageFetcher.value, isNot(equals(initialLoad)));
  });

  test('PageFetcher should handle loading multiple pages with prepend',
      () async {
    final pageFetcher = PageFetcher<int, String>(
      initialKey: 3,
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
      initialState: const PagingState(),
    );

    await pageFetcher.load(LoadType.refresh);
    final initialLoad = pageFetcher.value;

    await pageFetcher.load(LoadType.prepend);

    // Verify that pages are loaded and prepended correctly.
    expect(pageFetcher.value.pages.itemCount, equals(80));
    expect(pageFetcher.value, isNot(equals(initialLoad)));
  });

  test('PageFetcher should handle an initial load with an initialKey',
      () async {
    const initialKey = 2;
    final pageFetcher = PageFetcher<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
      initialKey: initialKey,
      initialState: const PagingState(),
    );

    await pageFetcher.load(LoadType.refresh);

    // Verify that the initialKey is respected in the load.
    expect(pageFetcher.value.pages[0].prevKey, equals(initialKey - 1));
    expect(pageFetcher.value.pages[0].nextKey, equals(initialKey + 1));
  });

  test('PageFetcher should handle a refresh', () async {
    final pageFetcher = PageFetcher<int, String>(
      config: const PagingConfig(pageSize: 20),
      pagingSource: const FakePagingSource(),
      initialState: const PagingState(),
    );

    await pageFetcher.load(LoadType.refresh);
    final initialLoad = pageFetcher.value;

    await pageFetcher.load(LoadType.append);

    // Verify that pages are appended.
    expect(pageFetcher.value.pages.itemCount, equals(80));
    expect(pageFetcher.value, isNot(equals(initialLoad)));

    await pageFetcher.load(LoadType.refresh);

    // Verify that pages are refreshed and reset.
    expect(pageFetcher.value.pages.itemCount, equals(60));
  });
}
