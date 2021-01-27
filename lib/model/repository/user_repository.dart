import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:min3_minstag_ram/model/database/database_manager.dart';




class UserRepository {

  /// [V-> VM -> M(R) -> M(DatabaseManager): FireStore(database)アクセス用]
  final DatabaseManager dbManager;
  UserRepository({this.dbManager});


  /// [(Firebase毎度のパターン)auth確認用のインスタンス生成]
  final FirebaseAuth _auth = FirebaseAuth.instance;


  /// [remoteに取得しにいくmethodゆえRに書く（V->VM->RゆえVMから呼ぶ）]
  Future<bool> isSignIn() async {
    final firebaseUser = await _auth.currentUser();
    /// [SignIn: 認証見に行きfirebaseUser存在していればtrue]
    if(firebaseUser != null){
      return true;
    }
    return false;
  }


}