import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/comment.dart';
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

  bool isLoading = false;

  List<Comment> comments = [];



  /// [FutureNoReturn(NL), Argu]
  Future<void> postComment(Post post) async {
    await postRepository.postComment(post, currentUser, comment);   /// [Comment()/commentId = currentUserのId]

    /// [After Comment: コメントしてdb保存した後に、紐づくpost向けに、コメントデータを持ってくる,,,更新]
    getComment(post.postId);
    notifyListeners();
  }



  /// [FutureNoReturn(NL), Argu]
  Future<void> getComment(String postId) async {
    isLoading = true;
    notifyListeners();

    comments = await postRepository.getComment(postId);
    print("comm370: vm: getComment: $getComment");
    isLoading = false;
    notifyListeners();
  }



  /// [FutureUseReturn, Argu]
  Future<User> getCommentUserInfo(String commentUserId) async {
    return await userRepository.getUserById(commentUserId);
  }


  /// [FutureNoReturn(NL), Argu]
  /// [VM: Delete,,,戻り値なし]
  Future<void> deleteComment(Post post, int commentIndex) async {
    final deleteCommentId = comments[commentIndex].commentId;   /// [delete対象のid必要]
    await postRepository.deleteComment(deleteCommentId);
    /// [処理終了後に、comment数内容の変更を反映せな]
    getComment(post.postId);
    notifyListeners();
  }


}