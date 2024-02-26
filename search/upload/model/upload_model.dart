
import 'package:json_annotation/json_annotation.dart';
import 'package:study_language_ai_flutter_project/lang_card/model/lang_card_model.dart';

part 'upload_model.g.dart';


@JsonSerializable(explicitToJson: true)
class UploadModel {

  final List<CardModel> cards;
  final String title;
  final String subtext;
  final String uid;
  final String docId;


 UploadModel({
    required this.cards,
   required this.title,
   required this.subtext,
   required this.uid,
   required this.docId,
});

 factory UploadModel.fromJson(Map<String, dynamic> json)
  => _$UploadModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadModelToJson(this);
}