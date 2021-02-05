import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/view/comment/components/comment_display_part.dart';
import 'package:min3_minstag_ram/view/comment/components/comment_input_part.dart';
import 'package:min3_minstag_ram/view/common/confirm_dialog.dart';
import 'package:min3_minstag_ram/viewmodel/comment_view_model.dart';
import 'package:provider/provider.dart';




/// [feed_post_likes_part.dart -> CommentScreen()]
class CommentScreen extends StatelessWidget {
  final Post post;   /// [コメント一覧: caption並べる]
  final User postUser;
  CommentScreen({@required this.post, @required this.postUser});


  @override
  Widget build(BuildContext context) {

    final commentViewModel = Provider.of<CommentViewModel>(context, listen: false);
    /// [Futureで逃がす]
    Future(  () => commentViewModel.getComment(post.postId)  );

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).comments),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(   /// [Tigar beet]
          child: Column(
            children: [
              /// [originalキャプション]
              CommentDisplayPart(
                postUserPhotoUrl: postUser.photoUrl,
                name: postUser.inAppUserName,
                text: post.caption,
                postDateTime: post.postDateTime,
              ),

              /// [コメントリスト(表示のみ)]
              Consumer<CommentViewModel>(
                builder: (context, model, child) {
                  return ListView.builder(
                    shrinkWrap: true,     /// [ERROR: Vertical viewport was given unbounded height.]
                    itemCount: model.comments.length,
                    itemBuilder: (context, index) {
                      final comment = model.comments[index];
                      final commentUserId = comment.commentUserId;   /// [Stop Infinite Circular: FutureBuilder()]
                      /// return ListTile(   [test]
                      //   title: Text(comment.commentId),
                      //   subtitle: Text(comment.comment),
                      // );
                      return FutureBuilder(
                        future: model.getCommentUserInfo(commentUserId),
                        builder: (context, AsyncSnapshot<User> snapshot) {
                          if (snapshot.hasData) {
                            /// [CommentDisplayPart()で必要なパラメタ取得のために下記定義]
                            final commentUser = snapshot.data;
                            return CommentDisplayPart(
                              name: commentUser.inAppUserName,
                              text: comment.comment,
                              postUserPhotoUrl: commentUser.photoUrl,
                              postDateTime: comment.commentDateTime,
                              /// [コメント時の長押し削除featureを追加]
                              onLongPressed: () => showConfirmDialog(
                                  context: context,
                                  title: S.of(context).deleteComment,
                                  content: S.of(context).deleteCommentConfirm,
                                  onConfirmed: (isConfirmed) {   /// [定型]
                                    if (isConfirmed) {
                                      _deleteComment(context, index);
                                    }
                                    
                                    
                                  },
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    },
                  );
                },
              ),

              /// [コメント入力欄: 対象post/feedへのコメントの追加: TextFieldが変更]
              CommentInputPart(post: post),
            ],
          ),
        ),
      ),
    );
  }



  void _deleteComment(BuildContext context, int commentIndex) async {
    final commentViewModel = Provider.of<CommentViewModel>(context, listen: false);
    await commentViewModel.deleteComment(post, commentIndex);


  }
}
