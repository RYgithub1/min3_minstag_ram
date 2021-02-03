/// import 'package:firebase_auth/firebase_auth.dart';   [Destructive chanegs]
import 'package:firebase_auth/firebase_auth.dart' as auth;   /// [FirebaseAuthのものは頭にautu.xxx必須で差別化]
// import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/model/database/database_manager.dart';




class UserRepository {

  /// [V-> VM -> M(R) -> M(DatabaseManager): FireStore(database)アクセス用]
  final DatabaseManager dbManager;
  UserRepository({this.dbManager});

  /// [アプリ全体で取得できるようにstatic: userのデータをとってくる(=Read)method:  用]
  static User currentUser;

  /// [(Firebase毎度のパターン)auth確認用のインスタンス生成]
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


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

  /// [feed_view.model.dart]
  // Future<User> getUserById(String userId) async {
  //   return await dbManager.getUserInfoFromDbById(userId);
  // }


}