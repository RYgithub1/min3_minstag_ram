import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;




/// [V-> VM -> M(R) -> M(DatabaseManager): FireStore(database)アクセス用]
class DatabaseManager {

  /// [cloid_firestore取得用インスタンスの作成]
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  /// [FireStoreから、検索条件を指定して、documentを取得する]
  Future<bool> searchUserInDb(auth.User firebaseUser) async {
    final query = await _db.collection("users")
        .where(
          "userId",   /// [DartDataClass->user.dart/property]
          isEqualTo: firebaseUser.uid,
        )
        .get();
    /// [取得結果documentにデータがある＝長さがある]
    /// [データ存在するか否かチェックして,repositoryにreturn]
    if(query.docs.length >= 0) {
      return true;
    } else {
      return false;
    }
  }




}
