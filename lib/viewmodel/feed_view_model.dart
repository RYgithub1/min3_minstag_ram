import 'package:flutter/material.dart';
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



  /// [FutureBuilderなので戻り値で返す]
  Future<User> getPostUserInfo(String userId) async {
    return await userRepository.getUserById(userId);
  }



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


}