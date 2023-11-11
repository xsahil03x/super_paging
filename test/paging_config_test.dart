import 'package:flutter_test/flutter_test.dart';
import 'package:super_pager/src/paging_config.dart';

void main() {
  group('PagingConfig', () {
    test('PagingConfig initializes with default values', () {
      const pagingConfig = PagingConfig(pageSize: 10);

      expect(pagingConfig.pageSize, 10);
      expect(pagingConfig.prefetchIndex, 3);
      expect(pagingConfig.initialLoadSize, 10 * PagingConfig.initialPageMultiplier);
      expect(pagingConfig.maxSize, isNull);
    });

    test('PagingConfig initializes with custom values', () {
      const pagingConfig = PagingConfig(
        pageSize: 15,
        prefetchIndex: 5,
        initialLoadSize: 50,
        maxSize: 1000,
      );

      expect(pagingConfig.pageSize, 15);
      expect(pagingConfig.prefetchIndex, 5);
      expect(pagingConfig.initialLoadSize, 50);
      expect(pagingConfig.maxSize, 1000);
    });

    test('PagingConfig asserts on prefetchIndex validation', () {
      expect(() => PagingConfig(pageSize: 10, prefetchIndex: 6),
          throwsA(isA<AssertionError>()));
    });

    test('PagingConfig asserts on maxSize validation', () {
      expect(() => PagingConfig(pageSize: 10, maxSize: 25),
          throwsA(isA<AssertionError>()));
    });

    test('PagingConfig asserts on maxSize constraint validation', () {
      expect(() => PagingConfig(pageSize: 10, prefetchIndex: 2, maxSize: 21),
          throwsA(isA<AssertionError>()));
    });

    test('PagingConfig with maxSize and prefetchIndex within constraint', () {
      const pagingConfig = PagingConfig(
        pageSize: 10,
        prefetchIndex: 2,
        maxSize: 100,
      );

      expect(pagingConfig.pageSize, 10);
      expect(pagingConfig.prefetchIndex, 2);
      expect(pagingConfig.maxSize, 100);
    });
  });
}
