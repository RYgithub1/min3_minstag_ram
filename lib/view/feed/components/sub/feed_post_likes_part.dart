import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/view/comment/screens/comment_screen.dart';
import 'package:min3_minstag_ram/view/common/style.dart';




class FeedPostLikesPart extends StatelessWidget {
  final Post post;   /// [CommentScreen(): caption一覧が欲しい、渡すため]
  final User postUser;
  FeedPostLikesPart({@required this.post, @required this.postUser});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: FaIcon(FontAwesomeIcons.solidHeart),
                onPressed: null,
              ),
              IconButton(   /// [To CommentScreen()]
                icon: FaIcon(FontAwesomeIcons.comment),
                /// [Routeでcontext, CommentScreen()にpost,が必要な為追記]
                onPressed: () => _openCommentScreen(context, post, postUser),
                ///  onPressed: _openCommentScreen(context, post),   /// [ERROR]
                /// onPressed: null,   /// [HERE]
              ),
            ],
          ),
          Text(
            "0 ${S.of(context).likes}",
            style: numberOfLikesTextStyle,
          ),
        ],
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


}
