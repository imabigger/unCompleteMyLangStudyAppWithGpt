
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/dio/dio.dart';
import 'package:study_language_ai_flutter_project/common/model/gpt_chat_body.dart';
import 'package:study_language_ai_flutter_project/common/model/gpt_chat_model.dart';
import 'package:cloud_functions/cloud_functions.dart';



final chatCompletionGptRepositoryProvider = Provider((ref) {
  return ChatCompletionGptRepository(); //
});

class ChatCompletionGptRepository{

  Future<GptChatModel> chatCompletion({
   required GptChatBody body,
  }) async {
    try {
      final result = await FirebaseFunctions.instance.httpsCallable('gptCallWithUrlAndBody').call(
        {
          "url": 'chat/completions',
          "body": body.toJson(),
        },
      );
      print(result.data);
      final jsonString = jsonEncode(result.data);
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      return GptChatModel.fromJson(data);
    } on FirebaseFunctionsException catch (error) {
      print(error.code);
      print(error.details);
      print(error.message);
      throw error;
    }
  }
}
