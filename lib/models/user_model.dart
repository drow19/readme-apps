import 'package:book_store_apps/models/book_data_res.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'userid')
  final int? userId;

  @JsonKey(name: 'username')
  final String? username;

  @JsonKey(name: 'password')
  final String? password;

  @JsonKey(name: 'avatar')
  final String? avatar;

  @JsonKey(name: 'favorite')
  final List<BookDataRes>? favorite;

  const UserModel({this.userId, this.username, this.password, this.avatar, this.favorite,});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    int? userId,
    String? username,
    String? password,
    String? avatar,
    List<BookDataRes>? favorite
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      favorite: favorite ?? this.favorite,
    );
  }
}
