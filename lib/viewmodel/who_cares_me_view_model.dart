import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/model/repository/user_repository.dart';
import 'package:min3_minstag_ram/util/constants.dart';




class WhoCaresMeViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  WhoCaresMeViewModel({this.userRepository});



  // List<User> caresMeUsers = [];
  List<User> caresMeUsers = List();
  /// [screenから呼びたい、currentUser持っておく]
  User get currentUser => UserRepository.currentUser;



  /// [FutureNoReturn, Argu]
  Future<void> getCaresMeUsers(String id, WhoCaresMeMode mode) async {
    caresMeUsers = await userRepository.getCaresMeUsers(id, mode);
    print("comm660: getCaresMeUsers: $caresMeUsers");
    notifyListeners();
  }


}