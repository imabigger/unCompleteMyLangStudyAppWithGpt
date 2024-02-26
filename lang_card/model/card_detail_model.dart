

import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';



class CardDetailFromJson{
  final List<CardDetailModel> response;

  CardDetailFromJson({
    required this.response,
});

  factory CardDetailFromJson.fromJson(Map<String, dynamic> json)
   => _$CardDetailFromJson(json);
}

CardDetailFromJson _$CardDetailFromJson(Map<String, dynamic> json) => CardDetailFromJson(
  response: (json['response'] as List<dynamic>)
      .map((e) => CardDetailModel(unit: e['unit'], explain: e['explain']))
      .toList(),
);