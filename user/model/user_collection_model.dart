
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCollectionModel {
  final int cookie;
  final int cash;
  final List<String>? uploadId;

  UserCollectionModel({
    required this.cookie,
    required this.cash,
    this.uploadId,
  });

  factory UserCollectionModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserCollectionModel(
      cookie: data?['cookie'],
      cash: data?['cash'],
      uploadId:
      data?['uploadId'] is Iterable ? List.from(data?['uploadId']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "cookie": cookie,
      "cash": cash,
      "uploadId": uploadId,
    };
  }

  factory UserCollectionModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return UserCollectionModel(
      cookie: map['cookie'],
      cash: map['cash'],
      uploadId:
      map['uploadId'] is Iterable ? List.from(map['uploadId']) : null,
    );
  }
}