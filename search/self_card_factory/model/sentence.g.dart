// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SentenceModel _$SentenceModelFromJson(Map<String, dynamic> json) =>
    SentenceModel(
      sentence:
          (json['sentence'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SentenceModelToJson(SentenceModel instance) =>
    <String, dynamic>{
      'sentence': instance.sentence,
    };
