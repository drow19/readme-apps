import 'package:json_annotation/json_annotation.dart';

part 'format_res.g.dart';

@JsonSerializable()
class FormatRes {
  @JsonKey(name: 'text/html')
  final String? textHtml;

  @JsonKey(name: 'text/html; charset=utf-8')
  final String? charsetHtml;

  @JsonKey(name: 'application/epub+zip')
  final String? appZip;

  @JsonKey(name: 'application/x-mobipocket-ebook')
  final String? ebook;

  @JsonKey(name: 'text/plain; charset=utf-8')
  final String? charsetPlain;

  @JsonKey(name: 'application/rdf+xml')
  final String? appXml;

  @JsonKey(name: 'application/octet-stream')
  final String? appStream;

  @JsonKey(name: 'text/plain; charset=us-ascii')
  final String? appAscii;

  @JsonKey(name: 'image/jpeg')
  final String? image;

  const FormatRes(
    this.textHtml,
    this.charsetHtml,
    this.appZip,
    this.ebook,
    this.charsetPlain,
    this.appXml,
    this.appStream,
    this.appAscii,
    this.image,
  );

  factory FormatRes.fromJson(Map<String, dynamic> json) {
    return _$FormatResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FormatResToJson(this);
}
