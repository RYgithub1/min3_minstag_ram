import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/comment.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/functions.dart';
import 'package:min3_minstag_ram/view/comment/screens/comment_screen.dart';
import 'package:min3_minstag_ram/view/common/comment_rich_text.dart';
import 'package:min3_minstag_ram/view/common/style.dart';
import 'package:min3_minstag_ram/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';




class FeedPostCommentsPart extends StatelessWidget {
  final Post post;
  final User postUser;
  FeedPostCommentsPart({@required this.post, @required this.postUser});


  @override
  Widget build(BuildContext context) {

    /// [future:でviewModelをcallしたい->Provider<TA>()定義]
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);   /// [To ESCAPE infinit: listenFalse]

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommentRichText(  /// [投稿者名とキャプション]
            name: postUser.inAppUserName,
            text: post.caption,
          ),
          InkWell(
            // onTap: null,
            onTap: () => _openCommentScreen(context, post, postUser),
            /// [NotifyListenerInfinitLoop: FutureBuilder()]
            // child: Text(
            //   "0 ${S.of(context).comments}",
            //   style: numberOfCommentsTextStyle,
            // ),
            child: FutureBuilder(
              /// [future:でviewModelをcallしたい->Provider<TA>()定義]
              future: feedViewModel.getComment(post.postId),
              builder: (context, AsyncSnapshot<List<Comment>> snapshot) {
                /// [snapshot取得: dataある && nullでない]
                if (snapshot.hasData && snapshot.data != null) {
                  final comments = snapshot.data;
                  return Text(
                    comments.length.toString() + " " + S.of(context).comments,
                    style: numberOfCommentsTextStyle,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Text(
            // "0時間前",
            createTimeAgoString(post.postDateTime),
            style: timeAgoTextStyle,
          ),
        ],
      ),
    );
  }


    _openCommentScreen(BuildContext context, Post post, User postUser) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CommentScreen(
        post: post,
        postUser: postUser,
      ),
    ));
  }
}


