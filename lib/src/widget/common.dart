import 'package:flutter/material.dart';

import 'package:super_paging/src/load_state.dart';
import 'package:super_paging/src/load_type.dart';
import 'package:super_paging/src/paging_source.dart';
import 'package:super_paging/src/paging_state.dart';

typedef PagingStateLoadingBuilder = WidgetBuilder;
typedef PagingStateEmptyBuilder = WidgetBuilder;

typedef PageListBuilder<K, V> = Widget Function(
  BuildContext context,
  PagingList<LoadResultPage<K, V>> pages,
  LoadState prependLoadState,
  LoadState appendLoadState,
);

typedef PagingStateErrorBuilder = Widget Function(
  BuildContext context,
  Object? error,
);

typedef LoadStateBuilder = Widget? Function(
  BuildContext context,
  LoadState state,
  void Function(LoadType loadType)? onLoadMoreTap,
  VoidCallback? onRetryTap,
);

typedef AppendStateBuilder = LoadStateBuilder;
typedef PrependStateBuilder = LoadStateBuilder;

typedef HeaderBuilder = WidgetBuilder;
typedef FooterBuilder = WidgetBuilder;

/// The default widget builder for the append state.
Widget? defaultPrependStateBuilder(
  BuildContext context,
  LoadState state,
  void Function(LoadType loadType)? onLoadMoreTap,
  VoidCallback? onRetryTap,
) {
  return _defaultLoadStateBuilder(
    context,
    LoadType.prepend,
    state,
    onLoadMoreTap,
    onRetryTap,
  );
}

/// The default widget builder for the append state.
Widget? defaultAppendStateBuilder(
  BuildContext context,
  LoadState state,
  void Function(LoadType loadType)? onLoadMoreTap,
  VoidCallback? onRetryTap,
) {
  return _defaultLoadStateBuilder(
    context,
    LoadType.append,
    state,
    onLoadMoreTap,
    onRetryTap,
  );
}

// The default widget builder for the append and prepend state.
Widget? _defaultLoadStateBuilder(
  BuildContext context,
  LoadType type,
  LoadState state,
  void Function(LoadType loadType)? onLoadMoreTap,
  VoidCallback? onRetryTap,
) {
  return state.when(
    notLoading: (endOfPaginationReached) {
      // Show nothing if there is no more data.
      //
      // This is the default behavior because it is the least surprising.
      // The alternative would be to show a message like "no more items".
      if (endOfPaginationReached) return null;

      // Show a simple tile to trigger loading more.
      return InkWell(
        onTap: switch (onLoadMoreTap) {
          final fn? => () => fn(type),
          _ => null,
        },
        child: const ListTile(
          title: Text('Load more'),
          trailing: Icon(Icons.refresh_rounded),
        ),
      );
    },
    loading: () {
      // Show a simple circular progress indicator to indicate loading.
      return const ListTile(
        title: Center(
          child: SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      );
    },
    error: (e) {
      // Show a retry tile if there was an error loading data.
      return InkWell(
        onTap: onRetryTap,
        child: const ListTile(
          title: Text('Error loading data!'),
          trailing: Icon(Icons.refresh_rounded),
        ),
      );
    },
  );
}
