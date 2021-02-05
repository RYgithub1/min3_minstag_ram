import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/comment.dart';
import 'package:min3_minstag_ram/data_models/like.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/model/repository/post_repository.dart';
import 'package:min3_minstag_ram/model/repository/user_repository.dart';
import 'package:min3_minstag_ram/util/constants.dart';




class FeedViewModel extends ChangeNotifier {

  /// [同様にfeedでもUser/Postデータ使う -> DI]
  final UserRepository userRepository;
  final PostRepository postRepository;
  FeedViewModel({this.userRepository, this.postRepository});


  bool isProcessing = false;
  List<Post> posts =[];

  /// [FROM_PROFILEの場合、自分とは限らず、特定のUserの情報を表示するため]
  User feedUser;
  User get currentUser => UserRepository.currentUser;
  void setFeedUser(FeedMode feedMode, User user) {
    if (feedMode == FeedMode.FROM_FEED) {
      feedUser = currentUser;
    } else {
      feedUser = user;   /// [渡された方のuser]
    }
  }


  // FeedViewModel向けcaption
  /// final String caption;  /// [final: コンストラクタに記入必須でエラー]
  String caption;   /// [外部から呼ぶのみ]




  /// [FutureNoReturn(NL), Argu]
  /// [feedを取得してUIへ: 2パターンfeedMode: Notifyゆえ<void>]
  Future<void> getPosts(FeedMode feedMode) async {
    isProcessing = true;
    notifyListeners();

    // await postRepository.getPosts(feedMode);
    /// [notify自動通知したい -> property定義 -> 代入]
    posts = await postRepository.getPosts(feedMode, feedUser);

    isProcessing = false;
    notifyListeners();
  }




  /// [FutureUserReturn, Argu]
  /// [FutureBuilderなので戻り値で返すreturn,,,AsyncSnapshot<同じ型>]
  Future<User> getPostUserInfo(String userId) async {
    return await userRepository.getUserById(userId);
  }




  /// [FutureNoReturn(NL), Argu]
  /// [Post->Feed: Update]
  Future<void> updatePost(Post post, FeedMode feedMode) async {
    isProcessing = true;
    await postRepository.updatePost(
      /// [DartDataClass: copyWith(): 更新したい対象一部、captionのみ可能]
      post.copyWith(caption: caption),
    );
    /// [処理完了後に一覧画面に戻ってくる...post投稿内容を再取得]
    await getPosts(feedMode);
    isProcessing = false;
    notifyListeners();
  }



  /// [FutureList<Comment>Return, Argu]
  /// [FutureBuilderゆえ、戻り値returnあり,,,,,,AsyncSnapshot<同じ型>]
  Future<List<Comment>> getComment(String postId) async {
    return await postRepository.getComment(postId);
  }



  /// [FutureNoReturn(NL), Argu]
  /// [通常VM: notifyListeners()ゆえ、returnなし]
  /// [代入していないので<void>: xxx = await feedViewModel.likeIt(post);]
  Future<void> likeIt(Post post) async {
    await postRepository.likeIt(post, currentUser);
    notifyListeners();
  }
  Future<void> unLikeIt(Post post) async {
    await postRepository.unLikeIt(post, currentUser);
    notifyListeners();
  }



  /// [FutureXXXReturn, Argu] -> [DDC: like.dart: LikeResultクラス定義をType]
  Future<LikeResult> getLikeResult(String postId) async {
    return await postRepository.getLikeResult(postId, currentUser);   /// [currentUser: 自分がいいねしたかの判定したい]
  }


  /// [FutureNoReturn, Argu]
  Future<void> deletePost(Post post, FeedMode feedMode) async {
    isProcessing = true;
    notifyListeners();

    await postRepository.deletePost(post.postId, post.imageStoragePath);   /// [紐づく画像(storage)も消す]
    await getPosts(feedMode);   /// [delete処理後にpost再取得]
    isProcessing = false;
    notifyListeners();
  }



}