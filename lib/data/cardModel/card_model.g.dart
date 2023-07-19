// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      id: json['id'] as int,
      title: json['name'] as String,
      image: json['img_thumb'] as String,
      shop: json['shop'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.title,
      'img_thumb': instance.image,
      'shop': instance.shop,
      'description': instance.description,
    };
