import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_language_ai_flutter_project/common/model/pagination_model.dart';
import 'package:study_language_ai_flutter_project/search/repository/random_card_repository.dart';
import 'package:study_language_ai_flutter_project/user/auth/auth.dart';

class PaginationProvider<T, U extends SearchRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
//CursorPagination<T> 하면 List<T>랑 비슷함. 비슷하게 List<T>를 모델화 한거임.

  final CollectionReference<Map<String, dynamic>> colRef;
  final U repo;

  PaginationProvider({
    required this.colRef,
    required this.repo,
  }) : super(CursorPaginationLoading()){
    paginate(fetchMore: true,fetchCount: 10);
  }

  Future<void> paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {

    if(Auth().currentUser == null) {
      state = CursorPaginationError(message: 'This service require Login');
    }
    

    if (forceRefetch) {
      List<T> data = await repo.getDocuments(colRef, fetchCount);

      state = CursorPagination<T>(data: data);
    } else {
      // count 만큼 state에 추가
      if (!fetchMore || state is CursorPaginationFetching) {
        return;
      }

      if (state is CursorPaginationLoading || state is CursorPaginationError) {
        state = CursorPaginationFetching(data: []);

        List<T> data = await repo.getDocuments(colRef, fetchCount);

        state = CursorPagination<T>(data: data);

        return;
      } else {
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetching(data: pState.data);

        List<T> data = await repo.getDocuments(colRef, fetchCount);

        if (data.isEmpty) {
          state = CursorPaginationError(message: '예상치 못한 error 발생');

          return;
        }

        state = pState.copyWith(data: [...pState.data, ...data]);
      }
    }
  }
}