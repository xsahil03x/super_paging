// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rick_and_morty_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RickAndMortyData _$RickAndMortyDataFromJson(Map<String, dynamic> json) =>
    RickAndMortyData(
      info: RickAndMortyInfo.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => RickAndMortyCharacter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

RickAndMortyInfo _$RickAndMortyInfoFromJson(Map<String, dynamic> json) =>
    RickAndMortyInfo(
      count: json['count'] as int,
      pages: json['pages'] as int,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );

RickAndMortyCharacter _$RickAndMortyCharacterFromJson(
        Map<String, dynamic> json) =>
    RickAndMortyCharacter(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      origin:
          RickAndMortyLocation.fromJson(json['origin'] as Map<String, dynamic>),
      location: RickAndMortyLocation.fromJson(
          json['location'] as Map<String, dynamic>),
      image: json['image'] as String,
      episode:
          (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
      url: json['url'] as String,
      created: json['created'] as String,
    );

RickAndMortyLocation _$RickAndMortyLocationFromJson(
        Map<String, dynamic> json) =>
    RickAndMortyLocation(
      name: json['name'] as String,
      url: json['url'] as String,
    );
