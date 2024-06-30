// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModelRes _$BookModelResFromJson(Map<String, dynamic> json) => BookModelRes(
      count: (json['count'] as num?)?.toInt(),
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      book: (json['results'] as List<dynamic>?)
          ?.map((e) => BookDataRes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookModelResToJson(BookModelRes instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.book,
    };
