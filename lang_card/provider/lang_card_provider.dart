
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';
import 'package:study_language_ai_flutter_project/common/model/gpt_chat_body.dart';
import 'package:study_language_ai_flutter_project/common/model/gpt_chat_model.dart';
import 'package:study_language_ai_flutter_project/common/repository/gpt_repository/gpt_chat_repository.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/card_detail_model.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';

final langCardProvider =
    StateNotifierProviderFamily<LangCardStateNotifier, List<CardModel>, String>(
        (ref, directory) {
  return LangCardStateNotifier(directory: directory);
});

class LangCardStateNotifier extends StateNotifier<List<CardModel>> {
  final String directory;

  LangCardStateNotifier({
    required this.directory,
  }) : super([]) {
    updateCardFromBox();
  }

  Future<void> updateCardFromBox() async {
    final box = Hive.box<List>(card_box_name);
    state.clear();

    if (directory == initial_Directory) {
      for (List e in box.values) {
        state.addAll(e.cast<CardModel>());
      }

      return;
    }

    final cards =
        box.get(directory, defaultValue: <CardModel>[])!.cast<CardModel>();

    state = cards;
  }

  Future<void> saveCards(List<CardModel> cards) async {
    final box = Hive.box<List>(card_box_name);

    state = [
      ...state,
      ...cards,
    ];

    await box.put(directory, state);
  }

  Future<void> saveTranslate(CardModel card) async {
    final box = Hive.box<List>(card_box_name);
    print(box.values);

    final index = state.indexWhere((e) => e.cardUniqueId == card.cardUniqueId);
    state.removeAt(index);
    state.insert(index, card);


    await box.put(directory, state);

  }

  Future<void> deleteCard(CardModel card) async {
    final box = Hive.box<List>(card_box_name);

    state.remove(card);
    await box.put(directory, state);
    return;
  }

  Future<void> translateCardLangToLang({
    required String currentLangString,
    required Lang currentLang,
    required Lang toLang,
    required CardModel card,
  }) async {
    final ChatCompletionGptRepository chatGptRepository =
        ChatCompletionGptRepository();

    final GptChatModel response = await chatGptRepository.chatCompletion(
        body: GptChatBody(model: 'gpt-3.5-turbo-0613', messages: [
      GptChatBodyMessages(
          role: GptRole.system,
          content:
              'You will be provided with a sentence in ${currentLang.name}, and your task is to translate it into ${toLang.name}.'
              '\nDo not make any comment, only sentence.'),
      GptChatBodyMessages(role: GptRole.user, content: currentLangString)
    ]));

    final transString = response.choices[0].message.content;

    card.addLang(language: toLang, transString: transString);

    saveTranslate(card);
  }

  Future<void> addCardDetailWordOrPhrase({
    required Lang userBaseLang,
    required Lang currentLang,
    required String currentLangString,
    required CardModel card,
  }) async {
    final ChatCompletionGptRepository chatGptRepository =
        ChatCompletionGptRepository();
// 혹시 나중에 까먹을지도 모르니 --> 이 함수는 번역이 되어있을 때 currentLangString을 받아와야한다. 즉 번역이 되어있는지 확신이 되어야 쓸수 있어!
    final targetStorage = card.langStorage.firstWhere((element) => element.language == currentLang);

    try {
      final GptChatModel response = await chatGptRepository.chatCompletion(
          body: GptChatBody(model: 'gpt-3.5-turbo-0613', messages: [ //여러가지 일을 한꺼번에 함.. gpt-4 를 해야 정확한 출력
        GptChatBodyMessages(
            role: GptRole.system,
            content:
                'You are word Json Maker : Extract smallest unit of meaning according to the corresponding language.'
            'Briefly explain the word and phrase in the user\'s language.'
                    '\n Json Form =>  {response : '
                    '[{ unit : ,explain : (pronunciation)}, { unit : ,explain : (pronunciation)} ,,,]}'),
        GptChatBodyMessages(role: GptRole.user, content: '{ '
            'userLang : ${userBaseLang.name}'
            'currentLang : ${currentLang.name}'
        'targetString : $currentLangString'
            '}')
      ]));

      CardDetailFromJson detailFromJson =  CardDetailFromJson.fromJson(jsonDecode(response.choices[0].message.content));

      targetStorage.addDetailCard(res: detailFromJson.response);

      saveTranslate(card);
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }
}
