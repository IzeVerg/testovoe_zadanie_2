import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardModel {
  CardModel({
    required this.id,
    required this.title,
    required this.image,
    required this.shop,
    required this.description,
  });

  final int id;
  @JsonKey(name: "name")
  final String title;
  @JsonKey(name: "img_thumb")
  final String image;
  final String shop;
  final String description;

  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);
}