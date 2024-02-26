import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_language_ai_flutter_project/search/repository/random_card_repository.dart';
import 'package:study_language_ai_flutter_project/search/upload/model/upload_model.dart';

class HotSuggestionRepository extends SearchRepository<UploadModel> {
  CollectionReference<Map<String, dynamic>> hotColRef;

  HotSuggestionRepository({required this.hotColRef});

  int count = 0;

  @override
  Future<List<UploadModel>> getDocuments(
      CollectionReference<Map<String, dynamic>> colRef, int fetchCount) async {

    print(count);

    List<String> docList =[];
    List<UploadModel> um = [];

    try {
      Query query = hotColRef
          .orderBy('count', descending: true);

      if (count > 0) {
        int startAfterValue = count ;  // 또는 마지막으로 가져온 'count' 값
        query = query.startAfter([startAfterValue]);
      }

      query = query.limit(fetchCount);

      QuerySnapshot querySnapshot = await query.get();

      for(var docSnapshot in querySnapshot.docs){
        docList.add(docSnapshot.id);
      }

      for (var docId in docList) {
        DocumentSnapshot docSnapshot = await colRef.doc(docId).get();
        if (docSnapshot.exists) {
          Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
          UploadModel uploadModel = UploadModel.fromJson(data);
          um.add(uploadModel);
        }
      }

      count+=fetchCount;
      return um;
    } on Exception catch (e) {
      // TODO
      print(e);
      return um;
    }
  }
}
