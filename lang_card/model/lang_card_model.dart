// 기본 CARD 모델
// CARD 다운, 만들기 , VIEW 모두 이 모델이 기반!
// Card 단어 추출 기능 -> CArdDetailModel!
// 단어 추출이 되었었다면 존재할 것이고, 없으면 존재하지 않을것을 이용하자.


import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';

part 'lang_card_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class CardModel {
  @HiveField(0)
  final String baseString;

  @HiveField(1)
  final String cardUniqueId;

  @HiveField(2)
  final Lang baseLang;

  @HiveField(3)
  late List<LangStorageModel> langStorage;

  @HiveField(4)
  final String cardDirectory;

  @HiveField(5)
  final String makerId;

  CardModel({
    required this.baseString,
    required this.cardUniqueId,
    required this.baseLang,
    required this.cardDirectory,
    required this.makerId,
  }) {
    langStorage = [LangStorageModel(language: baseLang, transString: baseString)];
  }

  bool addLang({
    required Lang language,
    required String transString,
}){
    final isExist = langStorage.any((element) => element.language == language);
    if(!isExist){
      langStorage.add(LangStorageModel(language: language, transString: transString));
      return true;
    } else{
      LangStorageModel langStorageModel = langStorage.firstWhere((element) => element.language == language);
      if(langStorageModel.transString.trim().isEmpty){
        langStorage.remove(langStorageModel);
        langStorage.add(LangStorageModel(language: language, transString: transString));
      }
    }
    return false;
  }

  factory CardModel.fromJson(Map<String, dynamic> json)
   => _$CardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class LangStorageModel {
  @HiveField(0)
  final Lang language;

  @HiveField(1)
  final String transString;

  @HiveField(2)
  late List<CardDetailModel> detailCards;

  LangStorageModel({
    required this.language,
    required this.transString,
  }){
    detailCards = [];
  }


  void addDetailCard({required List<CardDetailModel> res}){
    detailCards.addAll(res);
  }

  factory LangStorageModel.fromJson(Map<String, dynamic> json)
   => _$LangStorageModelFromJson(json);
  Map<String, dynamic> toJson() => _$LangStorageModelToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class CardDetailModel {
  @HiveField(0)
  final String unit;

  @HiveField(1)
  final String explain;

  CardDetailModel({
    required this.unit,
    required this.explain,
  });

  factory CardDetailModel.fromJson(Map<String, dynamic> json)
   => _$CardDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$CardDetailModelToJson(this);
}