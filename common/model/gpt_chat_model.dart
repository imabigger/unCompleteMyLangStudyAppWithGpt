import 'package:json_annotation/json_annotation.dart';

part 'gpt_chat_model.g.dart';

@JsonSerializable()
class GptChatModel {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<GptChatChoiceModel> choices;
  final GptChatUsageModel usage;

  GptChatModel({
    required this.id,
    required this.model,
    required this.object,
    required this.created,
    required this.choices,
    required this.usage,
  });

  factory GptChatModel.fromJson(Map<String, dynamic> json) =>
      _$GptChatModelFromJson(json);
}

@JsonSerializable()
class GptChatChoiceModel {
  final int index;
  final GptChatMessageModel message;
  final String finish_reason;

  GptChatChoiceModel({
    required this.index,
    required this.message,
    required this.finish_reason,
  });

  factory GptChatChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$GptChatChoiceModelFromJson(json);
}

@JsonSerializable()
class GptChatMessageModel {
  final String role;
  final String content;

  GptChatMessageModel({
    required this.role,
    required this.content,
  });

  factory GptChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$GptChatMessageModelFromJson(json);
}

@JsonSerializable()
class GptChatUsageModel {
  final int prompt_tokens;
  final int completion_tokens;
  final int total_tokens;

  GptChatUsageModel({
    required this.completion_tokens,
    required this.prompt_tokens,
    required this.total_tokens,
  });

  factory GptChatUsageModel.fromJson(Map<String, dynamic> json) =>
      _$GptChatUsageModelFromJson(json);

  Map<String, dynamic> toJson() => _$GptChatUsageModelToJson(this);
}
