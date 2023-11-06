import 'dart:convert';

import 'package:example/src/rick_and_morty_data.dart';

import 'package:http/http.dart' as http;

class RickAndMortyApi {
  late final _client = http.Client();

  Future<RickAndMortyData> getCharacters({required int page}) async {
    final res = await _client.get(
      Uri.parse("https://rickandmortyapi.com/api/character?page=$page"),
    );

    if (res.statusCode != 200) {
      throw Exception("Error getting movies");
    }

    return RickAndMortyData.fromJson(jsonDecode(res.body));
  }
}
