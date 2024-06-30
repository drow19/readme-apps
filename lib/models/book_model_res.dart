import 'package:book_store_apps/models/book_data_res.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_model_res.g.dart';

@JsonSerializable()
class BookModelRes {
  @JsonKey(name: 'count')
  final int? count;

  @JsonKey(name: 'next')
  final String? next;

  @JsonKey(name: 'previous')
  final String? previous;

  @JsonKey(name: 'results')
  final List<BookDataRes>? book;

  const BookModelRes({this.count, this.next, this.previous, this.book});

  factory BookModelRes.fromJson(Map<String, dynamic> json) {
    return _$BookModelResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BookModelResToJson(this);
}