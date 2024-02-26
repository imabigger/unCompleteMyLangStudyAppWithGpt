// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadModel _$UploadModelFromJson(Map<String, dynamic> json) => UploadModel(
      cards: (json['cards'] as List<dynamic>)
          .map((e) => CardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
      subtext: json['subtext'] as String,
      uid: json['uid'] as String,
      docId: json['docId'] as String,
    );

Map<String, dynamic> _$UploadModelToJson(UploadModel instance) =>
    <String, dynamic>{
      'cards': instance.cards.map((e) => e.toJson()).toList(),
      'title': instance.title,
      'subtext': instance.subtext,
      'uid': instance.uid,
      'docId': instance.docId,
    };
