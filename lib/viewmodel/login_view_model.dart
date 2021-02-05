import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/model/repository/user_repository.dart';




class LoginViewModel extends ChangeNotifier {
  /// [MVVM/Provider/DIの設計 -> 初期時にRepositoryフィールド定義]
  final UserRepository userRepository;
  LoginViewModel({this.userRepository});



  bool isLoading = false;
  bool isSuccessful = false;




  /// [ログイン済みか確認のmethod]
  /// [（V->VM->RゆえVから呼ぶ(Vに呼ぶコード書く)）]
  /// [Non Consumer: Use FutureBuilder(needs return)=戻り値boolかつreturn必須]
  /// [FutureBuilder: <Type> && Return]
  /// [BoolReturn, NoArgu]
  Future<bool> isSignIn() async {
    return await userRepository.isSignIn();
  }


  /// [ログインしていない->ログイン処理]
  /// [NoReturn(NL), NoArgu]
  Future<void> signIn() async {
    isLoading = true;
    notifyListeners();

    isSuccessful = await userRepository.signIn();
    isLoading = false;
    notifyListeners();
  }



}