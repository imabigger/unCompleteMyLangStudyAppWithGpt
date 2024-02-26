
import 'package:json_annotation/json_annotation.dart';
import 'package:study_language_ai_flutter_project/common/utill/utils.dart';

part 'gpt_chat_body.g.dart';

// {
// "model": "gpt-3.5-turbo",
// "messages": [{"role": "system", "content": "You are a helpful assistant."}, {"role": "user", "content": "Hello!"}]
// }

enum GptRole{
 system,
 user,
 assistant,
 function,
}


@JsonSerializable(explicitToJson: true)
class GptChatBody{
 final String model; //gpt3.5 or gpt4 or etc..
 final List<GptChatBodyMessages> messages;
 final int temperature;
 final int top_p;
 final int n;
 final bool stream;
 final int presence_penalty;
 final int frequency_penalty;
 final String user;

 
 GptChatBody({
  required this.model,
  required this.messages,
  this.temperature =1,
  this.top_p =1,
  this.n=1,
  this.stream=false,
  this.presence_penalty=0,
  this.frequency_penalty=0,
  this.user = '0',
});

 factory GptChatBody.fromJson(Map<String, dynamic> json)
  => _$GptChatBodyFromJson(json);

 Map<String, dynamic> toJson() => _$GptChatBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GptChatBodyMessages{
 @JsonKey(
  //fromJson: Util.changeStringToGptRole,
  toJson: Util.changeGptRoleToString,
 )
 final GptRole role;
 final String content;


 GptChatBodyMessages({
  required this.role,
  required this.content,

});

 factory GptChatBodyMessages.fromJson(Map<String, dynamic> json)
  => _$GptChatBodyMessagesFromJson(json);

 Map<String, dynamic> toJson() => _$GptChatBodyMessagesToJson(this);
}