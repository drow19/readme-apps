import 'package:book_store_apps/models/book_data_res.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite_model.g.dart';

@JsonSerializable()
class FavoriteModel {
  @JsonKey(name: 'userId')
  final int? userId;

  @JsonKey(name: 'favorite')
  final List<BookDataRes>? favorite;

  const FavoriteModel({this.userId, this.favorite});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return _$FavoriteModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FavoriteModelToJson(this);

  FavoriteModel copyWith({
    int? userId,
    List<BookDataRes>? favorite
  }) {
    return FavoriteModel(
      userId: userId ?? this.userId,
      favorite: favorite ?? this.favorite,
    );
  }
}