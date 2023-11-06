import 'package:json_annotation/json_annotation.dart';

part 'rick_and_morty_data.g.dart';

@JsonSerializable(createToJson: false)
class RickAndMortyData {
  const RickAndMortyData({
    required this.info,
    required this.results,
  });

  factory RickAndMortyData.fromJson(Map<String, dynamic> json) =>
      _$RickAndMortyDataFromJson(json);

  final RickAndMortyInfo info;
  final List<RickAndMortyCharacter> results;
}

@JsonSerializable(createToJson: false)
class RickAndMortyInfo {
  const RickAndMortyInfo({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory RickAndMortyInfo.fromJson(Map<String, dynamic> json) =>
      _$RickAndMortyInfoFromJson(json);

  final int count;
  final int pages;
  final String? next;
  final String? prev;
}

@JsonSerializable(createToJson: false)
class RickAndMortyCharacter {
  const RickAndMortyCharacter({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory RickAndMortyCharacter.fromJson(Map<String, dynamic> json) =>
      _$RickAndMortyCharacterFromJson(json);

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final RickAndMortyLocation origin;
  final RickAndMortyLocation location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;
}

@JsonSerializable(createToJson: false)
class RickAndMortyLocation {
  const RickAndMortyLocation({
    required this.name,
    required this.url,
  });

  factory RickAndMortyLocation.fromJson(Map<String, dynamic> json) =>
      _$RickAndMortyLocationFromJson(json);

  final String name;
  final String url;
}
