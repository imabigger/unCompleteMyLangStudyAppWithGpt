import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_language_ai_flutter_project/common/model/pagination_model.dart';
import 'package:study_language_ai_flutter_project/common/provider/data_base_provider.dart';
import 'package:study_language_ai_flutter_project/common/provider/pagination_provider.dart';
import 'package:study_language_ai_flutter_project/search/repository/random_card_repository.dart';

import 'package:study_language_ai_flutter_project/search/upload/model/upload_model.dart';

final paginationCardProvider =
    StateNotifierProvider<PaginationCardNotifier, CursorPaginationBase>((ref) {
  final db = ref.read(fireStoreProvider);

  return PaginationCardNotifier(db: db);
});



class PaginationCardNotifier
    extends PaginationProvider<UploadModel, RandomSuggestionRepository> {
  final FirebaseFirestore db;

  PaginationCardNotifier({required this.db})
      : super(
          colRef:
              db.collection('search').doc('uploaded').collection('userUpload'),
          repo: RandomSuggestionRepository(),
        );
}

