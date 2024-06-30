// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorRes _$AuthorResFromJson(Map<String, dynamic> json) => AuthorRes(
      name: json['name'] as String?,
      birthYear: (json['birth_year'] as num?)?.toInt(),
      deathYear: (json['death_year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthorResToJson(AuthorRes instance) => <String, dynamic>{
      'name': instance.name,
      'birth_year': instance.birthYear,
      'death_year': instance.deathYear,
    };
