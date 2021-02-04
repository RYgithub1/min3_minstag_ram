import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/common/confirm_dialog.dart';
import 'package:min3_minstag_ram/view/common/user_card.dart';
import 'package:min3_minstag_ram/view/post/components/post_caption_part.dart';
import 'package:min3_minstag_ram/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';




class FeedPostEditScreen extends StatelessWidget {
  final User postUser;
  final Post  post;
  final FeedMode feedMode;
  FeedPostEditScreen({@required this.postUser, @required this.post, @required this.feedMode});


  @override
  Widget build(BuildContext context) {
    return Consumer<FeedViewModel>(
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: model.isProcessing
                ? Container()
                : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
            title: model.isProcessing
                ? Text(S.of(context).underProcessing)
                : Text(S.of(context).editInfo),

            actions: <Widget>[   /// [(edit->)Update 用のボタンが必要 -> Dialog]
                model.isProcessing
                ? Container()
                : IconButton(
                  icon: Icon(Icons.done_all),
                  onPressed: () => showConfirmDialog(
                      context: context,
                      title: S.of(context).editPost,
                      content: S.of(context).editPostConfirm,
                      onConfirmed: (isConfirmed) {
                        if (isConfirmed) {
                          _updatePost(context);
                        }
                      },
                  ),
                ),
            ],
          ),
          body: model.isProcessing
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    UserCard(
                      onTap: null,
                      photoUrl: postUser.photoUrl,
                      title: postUser.inAppUserName,
                      subTitle: post.locationString,
                    ),
                    PostCaptionPart(
                      from: PostCaptionOpenMode.FROM_FEED,
                      post: post,   /// [編集のため]
                    ),
                  ],
                ),
              ),
        );
      },
    );
  }



  /// [(edit内容を)UPDATEする, V->VM->R->DB]
  Future<void> _updatePost(BuildContext context) async {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    await feedViewModel.updatePost(post, feedMode);
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => FeedPage(),
    // ));
    /// [popで十分: Feedに戻る]
    Navigator.pop(context);
  }
}