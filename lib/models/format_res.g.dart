// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'format_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormatRes _$FormatResFromJson(Map<String, dynamic> json) => FormatRes(
      json['text/html'] as String?,
      json['text/html; charset=utf-8'] as String?,
      json['application/epub+zip'] as String?,
      json['application/x-mobipocket-ebook'] as String?,
      json['text/plain; charset=utf-8'] as String?,
      json['application/rdf+xml'] as String?,
      json['application/octet-stream'] as String?,
      json['text/plain; charset=us-ascii'] as String?,
      json['image/jpeg'] as String?,
    );

Map<String, dynamic> _$FormatResToJson(FormatRes instance) => <String, dynamic>{
      'text/html': instance.textHtml,
      'text/html; charset=utf-8': instance.charsetHtml,
      'application/epub+zip': instance.appZip,
      'application/x-mobipocket-ebook': instance.ebook,
      'text/plain; charset=utf-8': instance.charsetPlain,
      'application/rdf+xml': instance.appXml,
      'application/octet-stream': instance.appStream,
      'text/plain; charset=us-ascii': instance.appAscii,
      'image/jpeg': instance.image,
    };
