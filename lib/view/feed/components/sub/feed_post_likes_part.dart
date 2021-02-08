import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_minstag_ram/data_models/like.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/comment/screens/comment_screen.dart';
import 'package:min3_minstag_ram/view/common/style.dart';
import 'package:min3_minstag_ram/view/who_cares_me/who_cares_me_screen.dart';
import 'package:min3_minstag_ram/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';




class FeedPostLikesPart extends StatelessWidget {
  final Post post;   /// [CommentScreen(): caption一覧が欲しい、渡すため]
  final User postUser;
  FeedPostLikesPart({@required this.post, @required this.postUser});


  @override
  Widget build(BuildContext context) {

    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);   /// [FutureBuilder用に作成]

    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      /// [（親）Feed_sub_pageでconsumerしている]
      /// [->（子）再度consumerする必要ないのでFutureBuilder(非同期時間差で自動取得)]
      child: FutureBuilder(
        future: feedViewModel.getLikeResult(post.postId),
        builder: (context, AsyncSnapshot<LikeResult> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
              final likeResult = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      /// [------- いいね -------]
                      likeResult.isLikedToThisPost  /// [有無の場合分け]
                          ? IconButton(   /// [いいね済み]
                            icon: FaIcon(FontAwesomeIcons.solidHeart),
                            onPressed: () => _unLikeIt(context),   /// [いいね取り消し処理]
                          )
                          : IconButton(   /// [いいね未だ]
                            icon: FaIcon(FontAwesomeIcons.heart),
                            onPressed: () => _likeIt(context),
                          ),
                      /// [------- コメント -------]
                      IconButton(   /// [To CommentScreen()]
                        icon: FaIcon(FontAwesomeIcons.comment),
                        /// [Routeでcontext, CommentScreen()にpost,が必要な為追記]
                        onPressed: () => _openCommentScreen(context, post, postUser),
                        ///  onPressed: _openCommentScreen(context, post),   /// [ERROR]
                        /// onPressed: null,   /// [HERE]
                      ),
                    ],
                  ),
                  GestureDetector(   /// [whoCaresMe]
                    onTap: () => _checkLikesUsers(context),
                    child: Text(
                      likeResult.likes.length.toString() + " " + S.of(context).likes,
                      style: numberOfLikesTextStyle,
                    ),
                  ),
                ],
              );

          } else {
            return Container();
          }
        },
      ),
    );
  }



  _openCommentScreen(BuildContext context, Post post, User postUser) {
    // await Future.delayed(Duration(seconds: 30));
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CommentScreen(
        post: post,
        postUser: postUser,
      ),
    ));
  }




  /// [いいね済み]
  _likeIt(BuildContext context) async {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    await feedViewModel.likeIt(post);
  }
  /// [いいね未だ]
  _unLikeIt(BuildContext context) async {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    await feedViewModel.unLikeIt(post);
  }



  /// [whoCaresMe]
  /// [PresentNoReturn, Argu]
  _checkLikesUsers(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => WhoCaresMeScreen(
        mode: WhoCaresMeMode.LIKE,
        id: post.postId,   /// [final Post post;]
      ),
    ));
  }



}
