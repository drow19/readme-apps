// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    FavoriteModel(
      userId: (json['userId'] as num?)?.toInt(),
      favorite: (json['favorite'] as List<dynamic>?)
          ?.map((e) => BookDataRes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'favorite': instance.favorite,
    };
