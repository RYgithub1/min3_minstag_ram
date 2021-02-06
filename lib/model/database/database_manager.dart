import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:min3_minstag_ram/data_models/comment.dart';
import 'package:min3_minstag_ram/data_models/like.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';




/// [V-> VM -> M(R) -> M(DatabaseManager): FireStore(database)アクセス用]
class DatabaseManager {



  /// [cloid_firestore取得用インスタンスの作成]
  final FirebaseFirestore _db = FirebaseFirestore.instance;



  /// [FutureBoorReturn, Argu]
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



  /// [FutureNoReturn, Argu]
  /// [crud: Create: firestore登録用]
  Future<void> insertUser(User user) async {
    await _db.collection("users").doc(user.userId).set(user.toMap());
  }



  /// [FutureUserReturn, Argu]
  /// [crud: Read: ]
  Future<User> getUserInfoFromDbById(String userId) async {
    final query = await _db.collection("users")
        .where("userId", isEqualTo: userId)
        .get();
    return User.fromMap(query.docs[0].data());
    // return User.fromMap(query.docs[0].data);
  }



  /// [FutureStringReturn, Argu]
  /// [void -> String: Future<S>]
  Future<String> uploadImageToStorage(File imageFile, String storageId) async {
    final storageRef = FirebaseStorage.instance.ref().child(storageId);
    final uploadTask = storageRef.putFile(imageFile);
    return uploadTask.then( (TaskSnapshot snapshot) => snapshot.ref.getDownloadURL() );   /// [Future.then().catchError()]
  }



  /// [FutureNoreturn, Argu]
  /// [post -> Firestore保存]
  Future<void> insertPost(Post post) async {
    await _db.collection("posts").doc(post.postId).set(post.toMap());
    print("comm600: DatabaseManager: insertPost: xxx");
  }



  /// [FutureList<Post>Return, Argu]
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
    /// [>> MAKE INDEX]
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



  /// [profile]
  /// [db: プロフィール画面に表示されているユーザーの投稿を取得]
  Future<List<Post>> getPostsByUser(String userId) async {
    final query = await _db.collection("posts").get();
    if (query.docs.length == 0) return List();
    var results = List<Post>();
    await _db.collection("posts")
              .where("userId", isEqualTo: userId)
              .orderBy("postDateTime", descending: true)
              .get()
              .then((value) => {
                value.docs.forEach((element) {
                  results.add(Post.fromMap(element.data()));
                }),
              });
    return results;
  }



  /// [FutureList<String>Return, Argu]
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



  /// [FutureNoReturn, Argu]
  /// [post->feed: Update: DB]
  Future<void> updatePost(Post updatePost) async {
    final reference = _db.collection("posts").doc(updatePost.postId);
    await reference.update(updatePost.toMap());
  }



  /// [FutureNoReturn, Argu]
  /// [postに紐づくコメント投稿]
  Future<void> postComment(Comment comment) async {
    await _db.collection("comments").doc(comment.commentId).set(comment.toMap());   /// [doc(任意16桁一意)]
  }



  /// [FutureList<Comment>Return, Argu]
  /// [db保存データのget]
  Future<List<Comment>> getComment(String postId) async {
    /// [データがない場合がある = 有無により判定してから、処理]
    // final query = _db.collection("comment").get();
    /// [await必要: ないと取得出来ず、quety.docs使えない]
    final query = await _db.collection("comments").get();
    if (query.docs.length == 0) {
      return List();
    }

    /// [返り値用リスト作成]
    var results = List<Comment>();
    await _db.collection("comments")
        .where("postId", isEqualTo: postId)   /// [commentに紐づく投稿のみ特定: where("dbのフィールド名", isEqualTo: 拾ってきたpostId)]
        .orderBy("commentDateTime")    /// [並び方をVに合わせて揃える]
        .get()     /// [取得したvalue: List型QuerySnapshot取得]
        .then((value) {   /// [Futureゆえ,,,F.then().catchError()可能,,,DartDataClass変換して格納]
          value.docs.forEach((element) {
            results.add(Comment.fromMap(element.data()));
          });
        });
    /// [>> MAKE INDEX]
    return results;
  }



  /// [FutureNoReturn, Argu]
  Future<void> deleteComent(String deleteCommentId) async {
    /// [まず対象コメントを取得]
    final reference = _db.collection("comments").doc(deleteCommentId);
    /// [削除]
    await reference.delete();
  }


  /// [FutureNoReturn, Argu]
  Future<void> likeIt(Like like) async {
    /// [crud: createのパターン]
    /// [collection("likes") ゆえ,likeのidをレコードdoc()に]
    await _db.collection("likes").doc(like.likeId).set(like.toMap());
  }
  Future<void> unLikeIt(Post post, User currentUser) async {
    /// [いいね取り消し=likeId指定不可 -> documentID取得して削除]
    /// [(1)ドキュメントID取得]
    final likeRef = await _db.collection("likes")
                              .where("postId", isEqualTo: post.postId)  /// [対象post]
                              .where("likeUserId", isEqualTo: currentUser.userId)   /// [currentUserがlikeした対象か]
                              .get();
    /// [(2)ドキュメントIDで、対象いいねを削除]
    likeRef.docs.forEach((element) async {
      final ref = _db.collection("likes").doc(element.id);
      await ref.delete();
    });
  }




  /// [FutureList<Like>Return, Argu]
  Future<List<Like>> getLikes(String postId) async {
    /// [データがあるか判定]
    final query = await _db.collection("likes").get();
    if (query.docs.length == 0) {
      return List();
    }
    var results = List<Like>();
    await _db.collection("likes")
        .where("postId", isEqualTo: postId)
        .orderBy("likeDateTime")
        .get()
        .then((value) => {
          value.docs.forEach((element) {
            /// [elementはmap形式: Map<String, dynamic> data()]
            results.add(Like.fromMap(element.data()));
          }),
        });
    return results;
  }



  /// [FutureNoReturn, Argu]
  Future<void> deletePost(String postId, String imageStoragePath) async {
    /// [DELETE: 紐づく全てを同時に消す: post,comment,like,storage画像]
    /// [>> post]
    final postRef = _db.collection("posts").doc(postId);
    await postRef.delete();
    /// [>> comment]
    final commentRef = await _db.collection("comments")
                            .where("postId", isEqualTo: postId)
                            .get();
    /// [ERROR: awaitないとdocs出てこない]
    commentRef.docs.forEach((element) async {
      final ref = _db.collection("comments").doc(element.id);
      await ref.delete();
    });
    /// [>> like]
    final likeRef = await _db.collection("likes")
                            .where("postId", isEqualTo: postId)
                            .get();
    likeRef.docs.forEach((element) async {
      final ref = _db.collection("likes").doc(element.id);
      await ref.delete();
    });
    /// [>> Storage画像 !!!]
    final storageref = FirebaseStorage.instance.ref().child(imageStoragePath);
    storageref.delete();
  }



  /// [Firestore格納の型: "idA","idB","idC","idD",,, -> List<String>]
  /// [FutureList<String>Return, Argu]
  Future<List<String>> getFollowerUserId(String userId) async {
    /// [Firestoreから取得したい = 取得結果判定]
    final query = await _db.collection("users").doc(userId)
                            .collection("followers").get();   /// [SubCollection]
    /// [THE Firestore: サブコレクションを設定可能]
    if (query.docs.length == 0) return List();
    var userIds = List<String>();
    query.docs.forEach((id) {
      /// [ERROR: data["userId"]] 前に()必要
      userIds.add(id.data()["userId"]);
    });
    return userIds;
  }


  /// [FutureNoReturm, Argu]
  Future<void> updateProfile(User updateUser) async {
    final reference = _db.collection("users").doc(updateUser.userId);
    await reference.update(updateUser.toMap());
  }



}
