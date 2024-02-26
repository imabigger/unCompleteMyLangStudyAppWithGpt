// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gpt_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GptChatModel _$GptChatModelFromJson(Map<String, dynamic> json) => GptChatModel(
      id: json['id'] as String,
      model: json['model'] as String,
      object: json['object'] as String,
      created: json['created'] as int,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => GptChatChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      usage: GptChatUsageModel.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GptChatModelToJson(GptChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices,
      'usage': instance.usage,
    };

GptChatChoiceModel _$GptChatChoiceModelFromJson(Map<String, dynamic> json) =>
    GptChatChoiceModel(
      index: json['index'] as int,
      message:
          GptChatMessageModel.fromJson(json['message'] as Map<String, dynamic>),
      finish_reason: json['finish_reason'] as String,
    );

Map<String, dynamic> _$GptChatChoiceModelToJson(GptChatChoiceModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'message': instance.message,
      'finish_reason': instance.finish_reason,
    };

GptChatMessageModel _$GptChatMessageModelFromJson(Map<String, dynamic> json) =>
    GptChatMessageModel(
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$GptChatMessageModelToJson(
        GptChatMessageModel instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };

GptChatUsageModel _$GptChatUsageModelFromJson(Map<String, dynamic> json) =>
    GptChatUsageModel(
      completion_tokens: json['completion_tokens'] as int,
      prompt_tokens: json['prompt_tokens'] as int,
      total_tokens: json['total_tokens'] as int,
    );

Map<String, dynamic> _$GptChatUsageModelToJson(GptChatUsageModel instance) =>
    <String, dynamic>{
      'prompt_tokens': instance.prompt_tokens,
      'completion_tokens': instance.completion_tokens,
      'total_tokens': instance.total_tokens,
    };
