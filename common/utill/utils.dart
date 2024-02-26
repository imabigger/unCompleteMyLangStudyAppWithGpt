
import 'package:flutter/material.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';
import 'package:study_language_ai_flutter_project/common/model/gpt_chat_body.dart';
import 'package:study_language_ai_flutter_project/common/model/gpt_chat_model.dart';
import 'package:study_language_ai_flutter_project/common/repository/gpt_repository/gpt_chat_repository.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';
import 'package:study_language_ai_flutter_project/user/auth/auth.dart';
import 'package:uuid/uuid.dart';

class Util {
  static changeGptRoleToString(GptRole role) => role.name;

  static CardModel makeCardModelFromDirectoryAndSentence(
      String directory, String sentence , Lang baseLang) {
    const uuid = Uuid();
    final u4 = uuid.v4();

    return CardModel(
      baseString: sentence,
      cardUniqueId: u4,
      baseLang: baseLang,
      cardDirectory: directory,
      makerId: Auth().currentUser!.uid, // 쿠키를 소모해야하는데, 쿠키는 로그인이 되어있을때만 소모가능
    );
  }

  static Lang? changeStringToLang(String? string) {
    if(string == null) return null;
    // String이 Lang의 Lang.name임이 보장될때만 사용!!!! 안그러면 null 오류
    return Lang.values.firstWhere((element) => element.name == string);
  }

  static Future<Lang> identifyStringLanguage(String string) async {
    // 문자열이 무슨 언어인지 반환해주는 함수....
    // ml kit 사용!
    //지원 안되는 언어는 막아두자..
    final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
    final lid = await languageIdentifier.identifyLanguage(string);


    print(lid);

    return changeLangIdentifyCodeToLang(lid);
  }

  static Lang changeLangIdentifyCodeToLang(String lid){
    return Lang.values.firstWhere((element) => element.name == MlKitPossibleLangMap[lid]);
  }

  static Future<void> showLoadingDialogUseTryCatch(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false, // 사용자가 다이얼로그 바깥을 터치하여 닫을 수 없도록 설정
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const Dialog(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text("Loading..."),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
