



import 'package:json_annotation/json_annotation.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';

part 'sentence.g.dart';

class SentenceModelBase {

  SentenceModelBase();
}



class SentenceModelLoading extends SentenceModelBase {

  SentenceModelLoading();
}



@JsonSerializable()
class SentenceModel extends SentenceModelBase {

  final List<String> sentence;

  @JsonKey(includeFromJson: false)
  List<Lang> lang = [];

 SentenceModel({
    required this.sentence,
});

 factory SentenceModel.fromJson(Map<String, dynamic> json)
  => _$SentenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SentenceModelToJson(this);
}