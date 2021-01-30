import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:min3_minstag_ram/data_models/user.dart';




/// [V-> VM -> M(R) -> M(DatabaseManager): FireStore(database)アクセス用]
class DatabaseManager {

  /// [cloid_firestore取得用インスタンスの作成]
  final FirebaseFirestore _db = FirebaseFirestore.instance;



  /// [crud: Read: FireStoreから、検索条件を指定して、documentを取得する]
  Future<bool> searchUserInDb(auth.User firebaseUser) async {
    final query = await _db.collection("users")
        .where("userId", isEqualTo: firebaseUser.uid)   /// [DartDataClass->user.dart/property]
        .get();
    /// [取得結果documentにデータがある＝長さがある]
    /// [データ存在するか否かチェックして,repositoryにreturn]
    if (query.docs.length > 0) {
      return true;
    }
    return false;
  }



  /// [crud: Create: firestore登録用]
  Future<void> insertUser(User user) async {
    await _db.collection("users").doc(user.userId).set(user.toMap());
  }



  /// [crud: Read: ]
  Future<User> getUserInfoFromDbById(String userId) async {
    final query = await _db.collection("users")
        .where("userId", isEqualTo: userId)
        .get();
    return User.fromMap(query.docs[0].data());
    // return User.fromMap(query.docs[0].data);
  }



}
