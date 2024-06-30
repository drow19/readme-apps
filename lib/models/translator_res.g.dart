// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translator_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslatorRes _$TranslatorResFromJson(Map<String, dynamic> json) =>
    TranslatorRes(
      name: json['name'] as String?,
      birthYear: (json['birth_year'] as num?)?.toInt(),
      deathYear: (json['death_year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TranslatorResToJson(TranslatorRes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birth_year': instance.birthYear,
      'death_year': instance.deathYear,
    };
