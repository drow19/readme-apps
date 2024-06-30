import 'package:json_annotation/json_annotation.dart';

part 'translator_res.g.dart';

@JsonSerializable()
class TranslatorRes {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'birth_year')
  final int? birthYear;

  @JsonKey(name: 'death_year')
  final int? deathYear;

  const TranslatorRes({this.name, this.birthYear, this.deathYear});

  factory TranslatorRes.fromJson(Map<String, dynamic> json) {
    return _$TranslatorResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TranslatorResToJson(this);
}