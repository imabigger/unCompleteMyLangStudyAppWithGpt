import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_language_ai_flutter_project/common/provider/data_base_provider.dart';
import 'package:study_language_ai_flutter_project/user/auth/auth.dart';
import 'package:study_language_ai_flutter_project/user/model/user_collection_model.dart';

final userCollectionProvider = StateNotifierProvider<UserCollectionNotifier,UserCollectionModel?>((ref) {
  final db = ref.read(fireStoreProvider);
  final docRef = db.collection("users").doc(Auth().currentUser?.uid);

  return UserCollectionNotifier(docRef: docRef);
});

class UserCollectionNotifier extends StateNotifier<UserCollectionModel?> {
  DocumentReference<Map<String, dynamic>> docRef;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _usersStream;

  UserCollectionNotifier({required this.docRef}) : super(null) {
    _initialize();

  }

  Future<void> _initialize() async {
    _usersStream = docRef.snapshots().listen((event) {
      if(event.data() == null) return;
      state = UserCollectionModel.fromMap(event.data()!);
      print('[read] firestore cloud');

      if(state == null){
        final data = UserCollectionModel(cookie: 10, cash: 0);
        print('[set] first firestore cloud');
        docRef.set(data.toFirestore());
      }
    });
  }

  @override
  void dispose() {
    _usersStream?.cancel();
    super.dispose();
  }
}
