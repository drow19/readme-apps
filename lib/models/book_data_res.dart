import 'package:book_store_apps/models/author_res.dart';
import 'package:book_store_apps/models/format_res.dart';
import 'package:book_store_apps/models/translator_res.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_data_res.g.dart';

@JsonSerializable()
class BookDataRes {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'copyright')
  final bool? copyright;

  @JsonKey(name: 'media_type')
  final String? mediaType;

  @JsonKey(name: 'download_count')
  final int? downloadCount;

  @JsonKey(name: 'languages')
  final List<String>? languages;

  @JsonKey(name: 'subjects')
  final List<String>? subjects;

  @JsonKey(name: 'bookshelves')
  final List<dynamic>? bookShelves;

  @JsonKey(fromJson: _authorsFromJson, toJson: _authorsToJson)
  final List<AuthorRes>? authors;

  @JsonKey(name: 'formats')
  final FormatRes? format;

  @JsonKey(name: 'translators')
  final List<TranslatorRes>? translator;

  const BookDataRes({
    this.id,
    this.title,
    this.copyright,
    this.mediaType,
    this.downloadCount,
    this.languages,
    this.subjects,
    this.bookShelves,
    this.authors,
    this.translator,
    this.format,
  });

  factory BookDataRes.fromJson(Map<String, dynamic> json) {
    return _$BookDataResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BookDataResToJson(this);

  static List<AuthorRes>? _authorsFromJson(List<dynamic> json) =>
      json.map((e) => AuthorRes.fromJson(e as Map<String, dynamic>)).toList();

  static List<dynamic> _authorsToJson(List<AuthorRes>? authors) =>
      authors!.map((e) => e.toJson()).toList();
}

