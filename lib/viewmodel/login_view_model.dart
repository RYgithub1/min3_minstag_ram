import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/model/repository/user_repository.dart';




class LoginViewModel extends ChangeNotifier {

  /// [MVVM/Provider/DIの設計 -> 初期時にRepositoryフィールド定義]
  final UserRepository userRepository;
  LoginViewModel({this.userRepository});




}