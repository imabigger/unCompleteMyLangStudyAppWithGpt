import 'package:flutter/material.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';

class CardBottomLangList extends StatelessWidget {
  final CardModel card;

  const CardBottomLangList({required this.card, super.key});

  @override
  Widget build(BuildContext context) {
    final langStorage = card.langStorage;

    return Wrap(
      spacing: 4.0,
      alignment: WrapAlignment.start,
      children: langStorage.map((currentLangStorage) {
        if (currentLangStorage.detailCards.isEmpty) {
          return Text(
            currentLangStorage.language.name,
            style: TextStyle(fontSize: 12.0),
          );
        }
        return Text(
          currentLangStorage.language.name,
          style: TextStyle(fontSize: 12.0,color: langColors[currentLangStorage.language]),
        );
      }).toList(),
    );
  }
}
