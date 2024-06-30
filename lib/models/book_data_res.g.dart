// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_data_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookDataRes _$BookDataResFromJson(Map<String, dynamic> json) => BookDataRes(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      copyright: json['copyright'] as bool?,
      mediaType: json['media_type'] as String?,
      downloadCount: (json['download_count'] as num?)?.toInt(),
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subjects: (json['subjects'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bookShelves: json['bookshelves'] as List<dynamic>?,
      authors: BookDataRes._authorsFromJson(json['authors'] as List),
      translator: (json['translators'] as List<dynamic>?)
          ?.map((e) => TranslatorRes.fromJson(e as Map<String, dynamic>))
          .toList(),
      format: json['formats'] == null
          ? null
          : FormatRes.fromJson(json['formats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookDataResToJson(BookDataRes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'copyright': instance.copyright,
      'media_type': instance.mediaType,
      'download_count': instance.downloadCount,
      'languages': instance.languages,
      'subjects': instance.subjects,
      'bookshelves': instance.bookShelves,
      'authors': BookDataRes._authorsToJson(instance.authors),
      'formats': instance.format,
      'translators': instance.translator,
    };
