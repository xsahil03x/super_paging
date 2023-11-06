import 'package:super_pager/super_pager.dart';

import 'rick_and_morty_data.dart';
import 'rick_and_morty_api.dart';

class RickAndMortySource extends PagingSource<int, RickAndMortyCharacter> {
  const RickAndMortySource({required this.api});

  final RickAndMortyApi api;

  @override
  Future<LoadResult<int, RickAndMortyCharacter>> load(
    LoadParams<int> params,
  ) async {
    try {
      final page = params.key ?? 1;
      final data = await api.getCharacters(page: page);

      int? nextPage;
      if (data.info.next != null) {
        final uri = Uri.parse(data.info.next!);
        final nextPageQuery = uri.queryParameters['page'];
        if (nextPageQuery != null) nextPage = int.parse(nextPageQuery);
      }

      int? prevPage;
      if (data.info.prev != null) {
        final uri = Uri.parse(data.info.prev!);
        final prevPageQuery = uri.queryParameters['page'];
        if (prevPageQuery != null) prevPage = int.parse(prevPageQuery);
      }

      return LoadResult.page(
        items: data.results,
        nextKey: nextPage,
        prevKey: prevPage,
      );
    } catch (e) {
      return LoadResult.error(e);
    }
  }
}
