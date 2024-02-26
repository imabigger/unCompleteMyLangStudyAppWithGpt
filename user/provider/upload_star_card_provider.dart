
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';


final starProvider = StateNotifierProvider<StarStateNotifier, List<String>>((ref) {
  return StarStateNotifier();
});

class StarStateNotifier extends StateNotifier<List<String>>{

  StarStateNotifier() : super([]){
    readStar();
  }

  Future<void> readStar() async {

      final starBox = Hive.box<String>(upload_star_card_box);

      state = starBox.values.toList();
  }

  Future<void> addStar(String docId) async {
    final starBox = Hive.box<String>(upload_star_card_box);

    state = [
      ...state,
      docId
    ];

    starBox.add(docId);
  }

  Future<void> deleteStar(String docId) async {

    final starBox = Hive.box<String>(upload_star_card_box);

    if(!state.contains(docId)){
      return; // 그런 문서 없는 경우
    }

    state = state.where((item) => item != docId).toList();
    starBox.clear();
    starBox.putAll(state.asMap());
  }
}