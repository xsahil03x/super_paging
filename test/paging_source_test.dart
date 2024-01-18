import 'package:flutter_test/flutter_test.dart';
import 'package:super_pager/src/paging_source.dart';

import 'fake_paging_source.dart';

void main() {
  group('PagingSource', () {
    test('load method returns a LoadResult', () async {
      const pagingSource = FakePagingSource();

      const loadParams = LoadParams<int>.refresh(key: null, loadSize: 10);

      final loadResult = await pagingSource.load(loadParams);

      expect(loadResult, isA<LoadResult>());
    });
  });

  group('LoadParams', () {
    test('LoadParams.refresh initializes correctly', () {
      const loadParams = LoadParams.refresh(key: null, loadSize: 10);

      // Check if the parameters are initialized correctly
      expect(loadParams.key, null);
      expect(loadParams.loadSize, 10);
    });

    test('LoadParams.append initializes correctly', () {
      const loadParams = LoadParams.append(key: 'appendKey', loadSize: 5);

      // Check if the parameters are initialized correctly
      expect(loadParams.key, 'appendKey');
      expect(loadParams.loadSize, 5);
    });

    test('LoadParams.prepend initializes correctly', () {
      const loadParams = LoadParams.prepend(key: 'prependKey', loadSize: 7);

      // Check if the parameters are initialized correctly
      expect(loadParams.key, 'prependKey');
      expect(loadParams.loadSize, 7);
    });
  });

  group('LoadResult', () {
    test('LoadResult.page initializes correctly', () {
      var loadResult = const LoadResult<String, String>.page(
        items: ['Item 1', 'Item 2'],
        prevKey: 'prevKey',
        nextKey: 'nextKey',
      );

      // Check if the parameters are initialized correctly
      expect(loadResult, isA<Page<String, String>>());

      loadResult = loadResult as Page<String, String>;
      expect(loadResult.items, ['Item 1', 'Item 2']);
      expect(loadResult.prevKey, 'prevKey');
      expect(loadResult.nextKey, 'nextKey');
    });

    test('LoadResult.error initializes correctly', () {
      var loadResult = LoadResult.error(Exception('An error occurred'));

      // Check if the parameters are initialized correctly
      expect(loadResult, isA<Error>());
      loadResult = loadResult as Error;
      expect(loadResult.error, isA<Exception>());
    });
  });

  // Additional tests for various scenarios
  test('LoadResult.page with null prevKey and nextKey', () {
    var loadResult = const LoadResult<String, String>.page(
      items: ['Item 1', 'Item 2'],
      prevKey: null,
      nextKey: null,
    );

    // Check if the parameters are initialized correctly
    expect(loadResult, isA<Page<String, String>>());

    loadResult = loadResult as Page<String, String>;
    expect(loadResult.prevKey, isNull);
    expect(loadResult.nextKey, isNull);
  });

  test('LoadResult.page with an empty items list', () {
    var loadResult = const LoadResult<String, String>.page(
      items: [],
      prevKey: 'prevKey',
      nextKey: 'nextKey',
    );

    // Check if the parameters are initialized correctly
    expect(loadResult, isA<Page<String, String>>());

    loadResult = loadResult as Page<String, String>;
    expect(loadResult.items, isEmpty);
  });
}
