import 'package:flutter/material.dart';

import '../load_state.dart';
import '../load_type.dart';
import '../pager.dart';

typedef PagingStateLoadingBuilder = WidgetBuilder;
typedef PagingStateEmptyBuilder = WidgetBuilder;

typedef PagingStateErrorBuilder = Widget Function(
  BuildContext context,
  Object? error,
);

typedef PrependStateBuilder<K, V> = Widget? Function(
  BuildContext context,
  LoadState state,
  Pager<K, V> pager,
);

typedef AppendStateBuilder<K, V> = Widget? Function(
  BuildContext context,
  LoadState state,
  Pager<K, V> pager,
);

typedef HeaderBuilder = WidgetBuilder;
typedef FooterBuilder = WidgetBuilder;

/// The default widget builder for the append state.
Widget? defaultPrependStateBuilder<K, V>(
  BuildContext context,
  LoadState state,
  Pager<K, V> pager,
) {
  return _defaultLoadMoreStateBuilder(
    context,
    LoadType.prepend,
    state,
    pager,
  );
}

/// The default widget builder for the append state.
Widget? defaultAppendStateBuilder<K, V>(
  BuildContext context,
  LoadState state,
  Pager<K, V> pager,
) {
  return _defaultLoadMoreStateBuilder(
    context,
    LoadType.append,
    state,
    pager,
  );
}

// The default widget builder for the append and prepend state.
Widget? _defaultLoadMoreStateBuilder<K, V>(
  BuildContext context,
  LoadType type,
  LoadState state,
  Pager<K, V> pager,
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
        onTap: () => pager.load(type),
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
        onTap: pager.retry,
        child: const ListTile(
          title: Text('Error loading data!'),
          trailing: Icon(Icons.refresh_rounded),
        ),
      );
    },
  );
}
