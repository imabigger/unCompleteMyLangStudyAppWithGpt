// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gpt_chat_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GptChatBody _$GptChatBodyFromJson(Map<String, dynamic> json) => GptChatBody(
      model: json['model'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => GptChatBodyMessages.fromJson(e as Map<String, dynamic>))
          .toList(),
      temperature: json['temperature'] as int? ?? 1,
      top_p: json['top_p'] as int? ?? 1,
      n: json['n'] as int? ?? 1,
      stream: json['stream'] as bool? ?? false,
      presence_penalty: json['presence_penalty'] as int? ?? 0,
      frequency_penalty: json['frequency_penalty'] as int? ?? 0,
      user: json['user'] as String? ?? '0',
    );

Map<String, dynamic> _$GptChatBodyToJson(GptChatBody instance) =>
    <String, dynamic>{
      'model': instance.model,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'temperature': instance.temperature,
      'top_p': instance.top_p,
      'n': instance.n,
      'stream': instance.stream,
      'presence_penalty': instance.presence_penalty,
      'frequency_penalty': instance.frequency_penalty,
      'user': instance.user,
    };

GptChatBodyMessages _$GptChatBodyMessagesFromJson(Map<String, dynamic> json) =>
    GptChatBodyMessages(
      role: $enumDecode(_$GptRoleEnumMap, json['role']),
      content: json['content'] as String,
    );

Map<String, dynamic> _$GptChatBodyMessagesToJson(
        GptChatBodyMessages instance) =>
    <String, dynamic>{
      'role': Util.changeGptRoleToString(instance.role),
      'content': instance.content,
    };

const _$GptRoleEnumMap = {
  GptRole.system: 'system',
  GptRole.user: 'user',
  GptRole.assistant: 'assistant',
  GptRole.function: 'function',
};
