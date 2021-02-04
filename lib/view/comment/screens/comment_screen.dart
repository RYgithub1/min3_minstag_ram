import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/view/comment/components/comment_display_part.dart';
import 'package:min3_minstag_ram/view/comment/components/comment_input_part.dart';




/// [feed_post_likes_part.dart -> CommentScreen()]
class CommentScreen extends StatelessWidget {
  final Post post;   /// [コメント一覧: caption並べる]
  final User postUser;
  CommentScreen({@required this.post, @required this.postUser});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).comments),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CommentDisplayPart(
              postUserPhotoUrl: postUser.photoUrl,
              name: postUser.inAppUserName,
              text: post.caption,
              postDateTime: post.postDateTime,
            ),
            
            /// [対象post/feedへのコメントの追加: TextFieldが変更]
            CommentInputPart(),
          ],
        ),
      ),
    );
  }
}
