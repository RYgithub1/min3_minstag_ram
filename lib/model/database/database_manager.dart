import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
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


  /// [void -> String: Future<S>]
  Future<String> uploadImageToStorage(File imageFile, String storageId) async {
    final storageRef = FirebaseStorage.instance.ref().child(storageId);
    final uploadTask = storageRef.putFile(imageFile);
    return uploadTask.then( (TaskSnapshot snapshot) => snapshot.ref.getDownloadURL() );   /// [Future.then().catchError()]
  }


  /// [post -> Firestore保存]
  Future<void> insertPost(Post post) async {
    await _db.collection("posts").doc(post.postId).set(post.toMap());
    print("comm600: DatabaseManager: insertPost: xxx");
  }




  /// [db: 自分がフォローしているユーザーの投稿を取得]
  Future<List<Post>> getPostsMineAndFollowings(String userId) async {
    /// [アプリダウン防ぐため: 投稿データ無いなら、return List()、返して終了]
    final query = await _db.collection("posts").get();
    if (query.docs.length == 0) return List();
    /// [userIdで対象特定。Firestore/users/ドキュメント/followers&&followingsを作成格納]
    var userIds = await getFollowingUserIds(userId);   /// [自分がフォローしているuserId]
    userIds.add(userId);   /// [に、自分のuserID、を加える]
    print("comm601: getPostsMineAndFollowings: userIds: $userIds");
    /// [========== データ取得(1) ==========]
    var results = List<Post>();
    print("comm602: getPostsMineAndFollowings: results: $results");
    await _db.collection("posts")
        .where("userId", whereIn: userIds)   /// [キーが複数: post取得、但しuserIdsリストに入っているuserIdのみ]
        .orderBy("postDateTime", descending: true)   /// [降順]
        .get()   /// [取得]
        .then((value) {   /// [get(): Futureゆえthen]
          value.docs.forEach((element) {   /// [docs << QueryDocumentSnapshot]
            results.add(Post.fromMap(element.data()));   /// [Map型 -> モデルクラス(Post)へ変換]
          });
        });
    print("comm603: getPostsMineAndFollowings: results: $results");
    return results;
    /// [========== データ取得(2): whereInは最大 10 個までの比較値しかサポートしていない件ゆえ書き換え ==========]
    /*
    var results = List<Post>();
    await Future.forEach(_, (id) async {
      await _db.collection("post").where("userId", isEqualTo: id).get().then((value) {
        value.docs.forEach((element) {
          results.add(Post.fromMap(element.data()));
        });
      });
    });
    return results;
    */
  }



  /// [db: プロフィール画面に表示されているユーザーの投稿を取得]
  Future<List<Post>> getPostsByUser(String userId) {
    return null;
  }



  Future<List<String>> getFollowingUserIds(String userId) async {
    final query = await _db.collection("users").doc(userId).collection("followings").get();   /// [followingsをここで作成]
    if (query.docs.length == 0) return List();
    var userIds = List<String>();
    query.docs.forEach((id) {
      userIds.add(id.data()[userId]);
    });
    print("comm605: getFollowingUserIds: userIds: $userIds");
    return userIds;
  }


  /// [post->feed: Update: DB]
  Future<void> updatePost(Post updatePost) async {
    final reference = _db.collection("posts").doc(updatePost.postId);
    await reference.update(updatePost.toMap());
  }



}
