import 'package:json_annotation/json_annotation.dart';

part 'author_res.g.dart';

@JsonSerializable()
class AuthorRes {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'birth_year')
  final int? birthYear;

  @JsonKey(name: 'death_year')
  final int? deathYear;

  const AuthorRes({this.name, this.birthYear, this.deathYear});

  factory AuthorRes.fromJson(Map<String, dynamic> json) {
    return _$AuthorResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthorResToJson(this);
}