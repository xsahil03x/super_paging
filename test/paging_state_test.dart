import 'package:flutter_test/flutter_test.dart';
import 'package:super_paging/super_paging.dart';

void main() {
  group('PagingState', () {
    test('PagingState.fromPages initializes correctly with non-empty pages',
        () {
      const pages = [
        LoadResultPage(items: ['Item 1'], prevKey: null, nextKey: 2),
        LoadResultPage(items: ['Item 2'], prevKey: 1, nextKey: 3),
        LoadResultPage(items: ['Item 3'], prevKey: 2, nextKey: null),
      ];

      final pagingState = PagingState.fromPages(pages);

      expect(pagingState.pages, pages);
      expect(pagingState.refreshLoadState, LoadState.notLoadingComplete);
      expect(pagingState.prependLoadState,
          const LoadState.notLoading(endOfPaginationReached: true));
      expect(pagingState.appendLoadState,
          const LoadState.notLoading(endOfPaginationReached: true));
    });

    test('PagingState.fromPages initializes correctly with empty pages', () {
      const pages = <LoadResultPage<int, String>>[];

      final pagingState = PagingState.fromPages(pages);

      expect(pagingState.pages, []);
      expect(pagingState.refreshLoadState, LoadState.notLoadingIncomplete);
      expect(pagingState.prependLoadState, LoadState.notLoadingIncomplete);
      expect(pagingState.appendLoadState, LoadState.notLoadingIncomplete);
    });
  });

  group('PagingListExtension', () {
    test('prevKey returns the correct value', () {
      const pages = [
        LoadResultPage(items: ['Item 2'], prevKey: 1, nextKey: 3),
        LoadResultPage(items: ['Item 3'], prevKey: 2, nextKey: 3),
      ];

      final key = pages.prevKey;

      expect(key, 1);
    });

    test('nextKey returns the correct value', () {
      const pages = [
        LoadResultPage(items: ['Item 1'], prevKey: null, nextKey: 2),
        LoadResultPage(items: ['Item 2'], prevKey: 1, nextKey: 3),
      ];

      final key = pages.nextKey;

      expect(key, 3);
    });

    test('items returns the correct list of items', () {
      const pages = [
        LoadResultPage(items: ['Item 1', 'Item 2']),
        LoadResultPage(items: ['Item 3']),
      ];

      final item = pages.items;

      expect(item, ['Item 1', 'Item 2', 'Item 3']);
    });

    test('itemCount returns the correct count of items', () {
      const pages = [
        LoadResultPage(items: ['Item 1', 'Item 2']),
        LoadResultPage(items: ['Item 3']),
      ];

      final count = pages.itemCount;

      expect(count, 3);
    });

    test('isListEmpty returns true for empty pages', () {
      const emptyPages = <LoadResultPage<int, String>>[];

      final isEmpty = emptyPages.isListEmpty;

      expect(isEmpty, true);
    });

    test('isListEmpty returns true for pages with empty items', () {
      const pagesWithEmptyItems = [
        LoadResultPage(items: []),
        LoadResultPage(items: []),
      ];

      final isEmpty = pagesWithEmptyItems.isListEmpty;

      expect(isEmpty, true);
    });

    test('isListEmpty returns false for pages with non-empty items', () {
      const pagesWithNonEmptyItems = [
        LoadResultPage(items: ['Item 1']),
        LoadResultPage(items: []),
      ];

      final isEmpty = pagesWithNonEmptyItems.isListEmpty;

      expect(isEmpty, false);
    });

    test('isListNotEmpty returns false for empty pages', () {
      const emptyPages = <LoadResultPage<int, String>>[];

      final isNotEmpty = emptyPages.isListNotEmpty;

      expect(isNotEmpty, false);
    });

    test('isListNotEmpty returns false for pages with empty items', () {
      const pagesWithEmptyItems = [
        LoadResultPage(items: []),
        LoadResultPage(items: []),
      ];

      final isNotEmpty = pagesWithEmptyItems.isListNotEmpty;

      expect(isNotEmpty, false);
    });

    test('isListNotEmpty returns true for pages with non-empty items', () {
      const pagesWithNonEmptyItems = [
        LoadResultPage(items: ['Item 1']),
        LoadResultPage(items: []),
      ];

      final isNotEmpty = pagesWithNonEmptyItems.isListNotEmpty;

      expect(isNotEmpty, true);
    });

    test('firstItemOrNull returns the first item if available', () {
      const pagesWithItems = [
        LoadResultPage(items: ['Item 1']),
        LoadResultPage(items: ['Item 2']),
      ];

      final item = pagesWithItems.firstItemOrNull;

      expect(item, 'Item 1');
    });

    test('firstItemOrNull returns null for empty pages', () {
      const emptyPages = <LoadResultPage<int, String>>[];

      final item = emptyPages.firstItemOrNull;

      expect(item, null);
    });

    test('firstItemOrNull returns null for pages with empty items', () {
      const pagesWithEmptyItems = [
        LoadResultPage(items: []),
        LoadResultPage(items: []),
      ];

      final item = pagesWithEmptyItems.firstItemOrNull;

      expect(item, null);
    });

    test('lastItemOrNull returns the last item if available', () {
      const pagesWithItems = [
        LoadResultPage(items: ['Item 1']),
        LoadResultPage(items: ['Item 2']),
      ];

      final item = pagesWithItems.lastItemOrNull;

      expect(item, 'Item 2');
    });

    test('lastItemOrNull returns null for empty pages', () {
      const emptyPages = <LoadResultPage<int, String>>[];

      final item = emptyPages.lastItemOrNull;

      expect(item, null);
    });

    test('lastItemOrNull returns null for pages with empty items', () {
      const pagesWithEmptyItems = [
        LoadResultPage(items: []),
        LoadResultPage(items: []),
      ];

      final item = pagesWithEmptyItems.lastItemOrNull;

      expect(item, null);
    });
  });
}
