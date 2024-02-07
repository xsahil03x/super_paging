# Super Pager

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/xsahil03x/multi_trigger_autocomplete/blob/master/LICENSE)
[![Dart CI](https://github.com/xsahil03x/super_pager/workflows/super_pager/badge.svg)](https://github.com/xsahil03x/super_pager/actions)
[![Version](https://img.shields.io/pub/v/super_pager.svg)](https://pub.dartlang.org/packages/super_pager)

Simplify Flutter pagination with Super Pager — A super package providing efficient data management, in-memory caching, configurable widgets and built-in error handling for a seamless pagination experience.

Live Demo: https://xsahil03x.github.io/super_pager

**Show some ❤️ and star the repo to support the project**

<kbd>
  <img src="https://github.com/xsahil03x/super_pager/blob/main/asset/package_demo.gif?raw=true" alt="An animated image of the SuperPager" height="400"/>
</kbd>

## Features

- **Efficient Pagination:** Seamlessly integrate SuperPager with Flutter for efficient paginated data management, ensuring a smooth user experience with large datasets.

- **In-memory Caching:** Benefit from in-memory caching for paged data, optimizing system resources and enhancing overall application performance.

- **Error Handling and Recovery:** SuperPager includes built-in support for error handling, empowering your app to recover gracefully from errors with features like refresh and retry capabilities.

- **State Management:** Leverage powerful state management with widgets like `PagingListView` and `BidirectionalPagingListView`, enabling the display of paginated data with support for loading, error, empty, and the actual list of items.

- **Flexible Configuration:** Tailor your pagination experience to your specific needs using the versatile SuperPager class. Configure initial keys, page sizes, and more to achieve the desired behavior.

## Installation

Add the following to your  `pubspec.yaml`  and replace  `[version]`  with the latest version:

```yaml
dependencies:
  super_pager: ^[version]
```

## Usage

To get started, import the package:

```dart
import 'package:super_pager/super_pager.dart';
```

Create a `PagingSource`:

```dart
class RickAndMortySource extends PagingSource<int, Character> {
  final RickAndMortyApi api;

  RickAndMortySource({required this.api});

  @override
  Future<LoadResult<int, Character>> load(PagingConfig<int> config, int key) async {
    try {
      final characters = await api.getCharacters(page: key);
      return LoadResult.page(nextKey: key + 1, items: characters);
    } catch (e) {
      return LoadResult.error(e);
    }
  }
}
```

Create a `SuperPager` Instance:

```dart
final pager = SuperPager(
  initialKey: 1,
  config: const PagingConfig(pageSize: 20, maxSize: 400),
  pagingSource: RickAndMortySource(api: RickAndMortyApi()),
);
```

Integrate with UI:

```dart
PagingListView(
  pager: pager,
  itemBuilder: (BuildContext context, int index) {
    final item = pager.items.elementAt(index);
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.species),
      trailing: Text('# ${item.id}'),
      leading: CircleAvatar(backgroundImage: NetworkImage(item.image)),
    );
  },
  emptyBuilder: (BuildContext context) {
    return const Center(
      child: Text('No characters found'),
    );
  },
  errorBuilder: (BuildContext context, Object? error) {
    return Center(child: Text('$error'));
  },
  loadingBuilder: (BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  },
);
```

Handle Refresh and Retry:

```dart
// Refresh the data
await pager.refresh();

// Retry failed loads
await pager.retry();
```

Dispose Resources:

```dart
@override
void dispose() {
  pager.dispose();
  super.dispose();
}
```

## Customization

### SuperPager

```dart
SuperPager(
  // Defines the initial key to use for the first load.
  //
  // By default, the initial key is null.
  initialKey: null,

  // Configuration for pagination behavior.
  config: PagingConfig(
    // Defines the number of items to load in a single page.
    pageSize: 20,
    
    // Defines the number of items to load in the first page.
    //
    // By default, the initial load size is 3 times the page size.
    initialLoadSize: 60,
    
    // Defines how far from the edge of loaded content an access
    // must be to trigger further loading.
    //
    // By default, the pager will start loading when the user scrolls
    // within 3 items of the end of the loaded content.
    //
    // If set to null, the pager will not start loading more content until
    // they are specifically requested by the user.
    prefetchIndex: 3,
    
    // Defines the maximum number of items to keep in memory before
    // pages should be dropped.
    //
    // If set to null (Default), pages will never be dropped.
    maxSize: null,
  ),

  // Defines the source from which to load the paginated data.
  pagingSource: MyPagingSource(),

  // Defines the initial state to use for the first load.
  //
  // By default, [PagingState.initial()] state is used.
  initialState: PagingState.initial(),
);
```

### PagingListView

```dart
PagingListView<int, String>(
  // Defines the pager to use for loading data.
  pager: myPager,

  // Defines the builder that is called to build items in the ListView.
  //
  // The builder is called once for each item in the list.
  itemBuilder: (context, index) {
    final item = myPager.valueList.elementAt(index);
    return ListTile(
      title: Text(item),
    );
  },

  // Defines the builder that is called to build the empty state of the list.
  emptyBuilder: (context) {
    return const Center(
      child: Text('No items found'),
    );
  },

  // Defines the builder that is called to build the error state of the list.
  //
  // [error] is the error that caused the state to be built.
  errorBuilder: (context, error) {
    return Center(child: Text('Error: $error'));
  },

  // Defines the builder that is called to build the loading state of the list.
  loadingBuilder: (context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  },

  // Defines the builder that is called to build the prepend state of the list.
  //
  // [state] is the current state of the pager and [pager] is the pager instance.
  //
  // Optional. If not provided, the list will show the default prepend loading state.
  prependStateBuilder: (context, state, pager) {
    // Return a widget based on the state. For example, a button to load the previous page.
    // Use the [pager] instance to call [pager.load()] or [pager.retry] based on the state.
  },

  // Defines the builder that is called to build the append state of the list.
  //
  // [state] is the current state of the pager and [pager] is the pager instance.
  //
  // Optional. If not provided, the list will show the default append loading state.
  appendStateBuilder: (context, state, pager) {
    // Return a widget based on the state. For example, a button to load the next page.
    // Use the [pager] instance to call [pager.load()] or [pager.retry] based on the state.
  },
);
```

## License

[MIT License](LICENSE)