import 'package:example/src/rick_and_morty_api.dart';
import 'package:example/src/rick_and_morty_source.dart';
import 'package:flutter/material.dart';
import 'package:super_paging/super_paging.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(useMaterial3: true),
      home: const RickAndMortyPage(),
    );
  }
}

class RickAndMortyPage extends StatefulWidget {
  const RickAndMortyPage({super.key});

  @override
  State<RickAndMortyPage> createState() => _RickAndMortyPageState();
}

class _RickAndMortyPageState extends State<RickAndMortyPage> {
  late final rickAndMortyPager = Pager(
    initialKey: 1, // Initial page to load.
    config: const PagingConfig(pageSize: 20, initialLoadSize: 60),
    pagingSource: RickAndMortySource(api: RickAndMortyApi()),
  );

  @override
  void dispose() {
    rickAndMortyPager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
      ),
      body: BidirectionalPagingListView(
        pager: rickAndMortyPager,
        itemBuilder: (BuildContext context, int index) {
          final item = rickAndMortyPager.items.elementAt(index);

          return ListTile(
            key: ValueKey(item.id),
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
      ),
    );
  }
}
