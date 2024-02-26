import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';
import 'package:study_language_ai_flutter_project/common/dio/dio.dart';
import 'package:study_language_ai_flutter_project/common/model/gpt_chat_body.dart';
import 'package:study_language_ai_flutter_project/common/model/gpt_chat_model.dart';
import 'package:study_language_ai_flutter_project/common/repository/gpt_repository/gpt_chat_repository.dart';
import 'package:study_language_ai_flutter_project/common/utill/utils.dart';
import 'package:study_language_ai_flutter_project/search/self_card_factory/model/sentence.dart';

final gptSentenceProvider = StateNotifierProvider<GptSentenceStateNotifier, SentenceModelBase>((ref) {

  final chatGptRepository = ref.watch(chatCompletionGptRepositoryProvider);

  return GptSentenceStateNotifier(chatGptRepository: chatGptRepository);
});



class GptSentenceStateNotifier extends StateNotifier<SentenceModelBase> {

  final ChatCompletionGptRepository chatGptRepository;

  GptSentenceStateNotifier({
    required this.chatGptRepository,
  }) : super(SentenceModelLoading()) ;

  Future<void> rawStringToJsonSentenceMaker(String rawString) async {
    state = SentenceModelLoading();

    try {
      final GptChatModel response = await chatGptRepository.chatCompletion(
          body: GptChatBody(model: 'gpt-3.5-turbo-16k-0613', messages: [
        GptChatBodyMessages(
            role: GptRole.system,
            content: 'You are sentence Json Maker : '
                'Please When a user sends a text, make the text one sentence at a time as Json.'
                '\nIf the sentence is too long ( over 16 words ), please adjust and cut it yourself.'),
        GptChatBodyMessages(
            role: GptRole.user,
            content:
                'The satisfaction of laziness is not worth the BRUTALITY of failure. The future is coming whether you are prepared or not.'),
        GptChatBodyMessages(
            role: GptRole.assistant,
            content:
                '{ "sentence" : [ "The satisfaction of laziness is not worth the BRUTALITY of failure.","The future is coming whether you are prepared or not."]}'),
        GptChatBodyMessages(role: GptRole.user, content: rawString)
      ]));

      print(response.choices[0].message.content);

      if(response.choices[0].finish_reason == 'content_filter'){
        throw Exception('content_filter');
      }

      print(jsonDecode(response.choices[0].message.content));

      final sentence = SentenceModel.fromJson(jsonDecode(response.choices[0].message.content));

//sentence.sentence 는 sentence로 이루어진 list
      // 한꺼번에 언어인식을 식별하는 코드가 필요함.

      // Util.identifyStringLanguage(string)
      List<Lang> lang = await Future.wait(sentence.sentence.map((string) => Util.identifyStringLanguage(string)));

      sentence.lang.addAll(lang);

      state = sentence;

      print(state);
    } on Exception catch (e) {
      if(e.toString() == 'Exception: content_filter'){
        state = SentenceModel(sentence: ['chat gpt : ${e.toString()} ( Copyright, dangerous and inappropriate content will be censored.) --> Err occurred'])..lang.add(Lang.English);
        return;
      }


      state = SentenceModel(sentence: ['${e.toString()} --> Err occurred'])..lang.add(Lang.English);
    }
  }


  void stateClear(){
    state = SentenceModelLoading();
  }
}
