import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/model/repository/post_repository.dart';
import 'package:min3_minstag_ram/model/repository/user_repository.dart';




class CommentViewModel extends ChangeNotifier {
  /// [CommmentでもUserとPost使うので]
  final UserRepository userRepository;
  final PostRepository postRepository;
  CommentViewModel({this.userRepository, this.postRepository});



  /// [getterで用意]
  /*
  User _currentUser = UserRepository.currentUser;
  User get currentUser => _currentUser;
  */
  /// [まとめて1行で書くと]
  User get currentUser => UserRepository.currentUser;   /// [コメントでログイン本人持参のため]

  String comment = "";



  Future<void> postComment(Post post) async {
    await postRepository.postComment(post, currentUser, comment);   /// [Comment()/commentId = currentUserのId]
    notifyListeners();



  }


}