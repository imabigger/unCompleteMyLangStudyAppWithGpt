import 'package:flutter/material.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';
import 'package:study_language_ai_flutter_project/search/self_card_factory/component/pre_lang_card.dart';

class SelfInputCardInfo {
  final GlobalKey<PreSentenceCardState> key;
  String value;
  Lang lang;

  SelfInputCardInfo({required this.key, required this.value, this.lang = Lang.English});
}