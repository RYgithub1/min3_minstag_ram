import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/model/repository/user_repository.dart';




class SearchViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  SearchViewModel({this.userRepository});



  List<User> soughtUsers = List();



  /// [PresentNoReturn, Argu, ,,,but事象が未来に発生,,,ゆえFuture]
  Future<void> searchUsers(String query) async {
    soughtUsers = await userRepository.searchUsers(query);
    // notifyListeners();
  }


}