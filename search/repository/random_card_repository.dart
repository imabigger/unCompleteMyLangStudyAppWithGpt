import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_language_ai_flutter_project/search/upload/model/upload_model.dart';
import 'package:uuid/uuid.dart';

abstract class SearchRepository<T> {
  Future<List<T>> getDocuments(CollectionReference<Map<String, dynamic>> colRef,int fetchCount);
}

class RandomSuggestionRepository extends SearchRepository<UploadModel> {
  @override
  Future<List<UploadModel>> getDocuments(CollectionReference<Map<String, dynamic>> colRef,int fetchCount) async {
    List<UploadModel> um = [];

    var uuid = const Uuid();
    String randomUuid = uuid.v4();

    try {
      QuerySnapshot querySnapshot = await colRef
          .orderBy(FieldPath.documentId)
          .startAt([randomUuid])
          .limit(fetchCount)
          .get();

      if(querySnapshot.size < 10){
        QuerySnapshot querySnapshot_lower = await colRef
            .orderBy(FieldPath.documentId)
            .endAt([randomUuid])
            .limit(fetchCount - querySnapshot.size)
            .get();

        for (var docSnapshot in querySnapshot_lower.docs) {
          um.add(UploadModel.fromJson(docSnapshot.data() as Map<String, dynamic>));
        }
      }


      // 가져온 문서 처리
      for (var docSnapshot in querySnapshot.docs) {
        um.add(UploadModel.fromJson(docSnapshot.data() as Map<String, dynamic>));
      }

      return um;
    } on Exception catch (e) {
      print('[err] $e');
      return um;
    }
  }
}

