import 'package:super_paging/super_paging.dart';

class FakePagingSource extends PagingSource<int, String> {
  const FakePagingSource({this.totalPageCount = 100});

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
