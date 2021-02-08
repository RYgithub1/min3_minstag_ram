import 'dart:io';

/// import 'package:firebase_auth/firebase_auth.dart';   [Destructive chanegs]
import 'package:firebase_auth/firebase_auth.dart' as auth;   /// [FirebaseAuthのものは頭にautu.xxx必須で差別化]
// import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/model/database/database_manager.dart';
import 'package:uuid/uuid.dart';




class UserRepository {
  /// [V-> VM -> M(R) -> M(DatabaseManager): FireStore(database)アクセス用]
  final DatabaseManager dbManager;
  UserRepository({this.dbManager});



  /// [アプリ全体で取得できるようにstatic: userのデータをとってくる(=Read)method:  用]
  static User currentUser;

  /// [(Firebase毎度のパターン)auth確認用のインスタンス生成]
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();



  /// [FutureBoolReturn, NoArgu]
  /// [remoteに取得しにいくmethodゆえRに書く（V->VM->RゆえVMから呼ぶ）]
  Future<bool> isSignIn() async {
    /// final firebaseUser = await _auth.currentUser();   /// [breaking:]
    final firebaseUser = _auth.currentUser;
    /// [_authを突破したcurrentUserが存在するか否か]
    /// [SignIn: 認証見に行きfirebaseUser存在していればtrue]
    if(firebaseUser != null){

      /// [後でsignOutメソ使うとログインログが残り、"static User currentUser = null"になるので、dbからのデータを代入しておく]
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);

      return true;
    }
    return false;
  }



  /// [FutureBoolReturn, NoArgu]
  Future<bool> signIn() async{
    try {
      GoogleSignInAccount signInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication signInAuthentication = await signInAccount.authentication;

      /// [ggにログインして認証 -> idtoken/accesstokenで信用状credentialの作成]
      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken,
      );

      final firebaseUser = (await _auth.signInWithCredential(credential)).user;
      /// [ifもし取得したfirebase内にuserがいなければ,早期return]
      if (firebaseUser == null) {
        return false;
      }

      /// [残りは,Firebase上にuserがいる場合(まずDBにそもそもいるか確認)]
      /// [database_manager.dart見てuser有無return]
      // await dbManager.searchUserInDb(firebaseUser);
      final isUserExistedInDb = await dbManager.searchUserInDb(firebaseUser);
      /// [firestore（DB）にuserいなかったら登録する]
      if(!isUserExistedInDb){
        await dbManager.insertUser(_convertToUser(firebaseUser));
        /// [_convertToUser: DDCで作成したuser.dart/propertyと、firebase/PlatformUserInfo()/propertyが異なるので変換]
      }

      /// [userのデータをとってくる(=Read)method: 戻り値は<User>]
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      print("comm001: try");
      return true;

    } catch(error) {
    // } on PlatformException catch (error) {
      print("comm002: error: UserRepository()/signIn(): ${error.toString()}");
      return false;
    } finally {
      print("comm003: finally: UserRepository()/signIn()");
    }
  }



  /// [method(){}]
  _convertToUser(auth.User firebaseUser) {
    return User(
      userId: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      inAppUserName: firebaseUser.displayName,   /// [初期は登録時の上と同様にしとく]
      photoUrl: firebaseUser.photoURL,
      email: firebaseUser.email,
      bio: "",
    );
  }



  /// [FutureUserReturn, Argu]
  /// [Feed: FutureBuilder]
  Future<User> getUserById(String userId) async {
    return await dbManager.getUserInfoFromDbById(userId);
  }


  /// [FutureNoReturn, NoArgu]
  Future<void> signOut() async {
    /// [googleからsignOut && firebaseからsignOut]
    await _googleSignIn.signOut();   /// [.disconnect(): エラー発生中]
    await _auth.signOut();
    /// [合わせてpropertyに残ったユーザー情報も消さないと、データ残存]
    currentUser = null;
  }


  /// [profile: follower number]
  /// [FutureIntReturn, Argu]
  Future<int> getNumberOfFollowers(User profileUser) async {
    final getFollowerUserIdList =  await dbManager.getFollowerUserIds(profileUser.userId);
    return getFollowerUserIdList.length;
  }
  /// [profile: follower number]
  Future<int> getNumberOfFollowings(User profileUser) async {
    final getFollowingUserIdList =  await dbManager.getFollowingUserIds(profileUser.userId);
    return getFollowingUserIdList.length;
  }



  /// [FutureNoReturn, Argu]
  Future<void> updateProfile(User profileUser, String photoUrlUpdated, bool isImageFromFile, String nameUpdated, String bioUpdated) async {
    /// [写真の更新: 一度Firestoreに登録して、から取得]
    var updatePhotoUrl;
    if (isImageFromFile) {
      final updatePhotoFile = File(photoUrlUpdated);
      final storagePath = Uuid().v1();
      updatePhotoUrl = await dbManager.uploadImageToStorage(updatePhotoFile, storagePath);
    }

    final userBeforeUpdate = await dbManager.getUserInfoFromDbById(profileUser.userId);
    /// [一部編集copyWith()]
    final updateUser = userBeforeUpdate.copyWith(
      inAppUserName: nameUpdated,
      photoUrl: isImageFromFile
          ? updatePhotoUrl
          : userBeforeUpdate.photoUrl,
      bio: bioUpdated,
    );
    await dbManager.updateProfile(updateUser);
  }




  /// [FutureNoReturn, Argu]
  Future<void> getCurrentUserById(String userId) async {
    /// [db更新 -> 残っているcurrentUserデータの更新]
    currentUser = await dbManager.getUserInfoFromDbById(userId);
  }


  /// [FutureList<User>Return, Argu]
  Future<List<User>> searchUsers(String query) async {
    return dbManager.searchUsers(query);
  }



  /// [FOLLOW]
  /// [FutureNoReturn, Argu]
  Future<void> follow(User profileUser) async {
    /// [collection("users")の中に、両側subCollection(followers/followings)作成]
    await dbManager.follow(profileUser, currentUser);
  }

  /// [UNFOLLOW]
  /// [FutureNoReturn, Argu]
  Future<void> unFollow(User profileUser) async {
    await dbManager.unFollow(profileUser, currentUser);
  }

  /// [フォロー後に、ボタンが切り替わらない対応]
  /// [FutureBoolReturn, Argu]
  Future<bool> checkIsFollowing(User profileUser) async {
    return await dbManager.checkIsFollowing(profileUser, currentUser);
  }



}