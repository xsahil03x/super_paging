import 'package:super_pager/super_pager.dart';

class MockPagingSource extends PagingSource<int, String> {
  const MockPagingSource({this.totalPageCount = 100});

  final int totalPageCount;

  @override
  Future<LoadResult<int, String>> load(LoadParams<int> params) async {
    final loadSize = params.loadSize;
    final currentPageKey = params.key ?? 1;

    final items = List.generate(
      loadSize,
      (index) => 'Page $currentPageKey -> Item ${index + 1}',
    );

    return LoadResult.page(
      items: items,
      prevKey: currentPageKey == 1 ? null : currentPageKey - 1,
      nextKey: currentPageKey == totalPageCount ? null : currentPageKey + 1,
    );
  }
}

class ErrorPagingSource extends PagingSource<int, String> {
  @override
  Future<LoadResult<int, String>> load(LoadParams<int> params) async {
    // Simulate an error by returning an error result.
    return const LoadResult.error("Error loading data");
  }
}
