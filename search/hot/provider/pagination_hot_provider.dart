import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_language_ai_flutter_project/common/model/pagination_model.dart';
import 'package:study_language_ai_flutter_project/common/provider/data_base_provider.dart';
import 'package:study_language_ai_flutter_project/common/provider/pagination_provider.dart';
import 'package:study_language_ai_flutter_project/search/hot/repository/hot_card_repository.dart';
import 'package:study_language_ai_flutter_project/search/repository/random_card_repository.dart';
import 'package:study_language_ai_flutter_project/search/upload/model/upload_model.dart';

enum HotDocName { //21074167-f498-4ae5-869a-79441ca3a5fd
  download_count,
  searched_count,
}

final paginationHotProvider = StateNotifierProvider.family<
    PaginationHotNotifier, CursorPaginationBase, HotDocName>((ref, hotEnum) {
  final db = ref.read(fireStoreProvider);

  return PaginationHotNotifier(db: db, hotCol: hotEnum.name);
});

class PaginationHotNotifier
    extends PaginationProvider<UploadModel, HotSuggestionRepository> {
  final FirebaseFirestore db;
  final String hotCol;

  PaginationHotNotifier({required this.db, required this.hotCol})
      : super(
          colRef:
              db.collection('search').doc('uploaded').collection('userUpload'),
          repo: HotSuggestionRepository(
              hotColRef: db.collection('search').doc('hot').collection(hotCol)),
        );
}
