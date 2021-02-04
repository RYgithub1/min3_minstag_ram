import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/functions.dart';
import 'package:min3_minstag_ram/view/common/comment_rich_text.dart';
import 'package:min3_minstag_ram/view/common/style.dart';




class FeedPostCommentsPart extends StatelessWidget {
  final Post post;
  final User postUser;
  FeedPostCommentsPart({@required this.post, @required this.postUser});


  @override
  Widget build(BuildContext context) {
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
            onTap: null,
            child: Text(
              "0 ${S.of(context).comments}",
              style: numberOfCommentsTextStyle,
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
}