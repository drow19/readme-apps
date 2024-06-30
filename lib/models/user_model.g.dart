// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: (json['userid'] as num?)?.toInt(),
      username: json['username'] as String?,
      password: json['password'] as String?,
      avatar: json['avatar'] as String?,
      favorite: (json['favorite'] as List<dynamic>?)
          ?.map((e) => BookDataRes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userid': instance.userId,
      'username': instance.username,
      'password': instance.password,
      'avatar': instance.avatar,
      'favorite': instance.favorite,
    };
