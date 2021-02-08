import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/common/confirm_dialog.dart';
import 'package:min3_minstag_ram/view/common/user_card.dart';
import 'package:min3_minstag_ram/view/feed/screens/feed_post_edit_screen.dart';
import 'package:min3_minstag_ram/view/profile/screens/profile_screen.dart';
import 'package:min3_minstag_ram/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';




class FeedPostHeaderPart extends StatelessWidget {
  /// [ないので追加]
  final FeedMode feedMode;

  final User postUser;
  final Post post;
  final User currentUser;
  /// [投稿ユーザーの情報があればよい...subTitleは投稿時の場所post...本人の投稿かで可能なcrud変わるcurrentUser]
  FeedPostHeaderPart({@required this.postUser, @required this.post, @required this.currentUser, @required this.feedMode});

  @override
  Widget build(BuildContext context) {
    return UserCard(
      /// onTap: null,  [PROFILE読み込みへ]
      /// onTap: _openProfile(context, postUser), [ERROR]
      onTap: () => _openProfile(context, postUser),
      photoUrl: postUser.photoUrl,
      title: postUser.inAppUserName,
      subTitle: post.locationString,
      trailing: PopupMenuButton(   /// [vs DropdownButton]
        icon: Icon(Icons.more_vert),
        onSelected: (value) => _onPopupMenuSelected(context, value),
        itemBuilder: (context) {
          if (postUser.userId == currentUser.userId) {  /// [判定: 投稿者が自分なら編集など権限]
            return [
              PopupMenuItem(value: PostMenu.EDIT, child: Text(S.of(context).edit)),
              PopupMenuItem(value: PostMenu.DELETE, child: Text(S.of(context).delete)),
              PopupMenuItem(value: PostMenu.SHARE, child: Text(S.of(context).share)),
            ];
          } else {
            return [
              PopupMenuItem(value: PostMenu.SHARE, child: Text(S.of(context).share)),
            ];
          }
        },
      ),
    );
  }



  _onPopupMenuSelected(BuildContext context, PostMenu selectedMenu) {
    switch (selectedMenu) {
      case PostMenu.EDIT:
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => FeedPostEditScreen(
            post: post,
            postUser: postUser,
            feedMode: feedMode,
          ),
        ));
        break;
      case PostMenu.SHARE:   /// [SHAREこれだけ]
        Share.share(
          post.imageUrl,
          subject: post.caption,
        );
        break;
      // default:
      /// [DELETEは最後に実装: post->comment->like->posdDelete: 全部一気に消すから]
      case PostMenu.DELETE:
        showConfirmDialog(
          context: context,
          title: S.of(context).deletePost,
          content: S.of(context).deletePostConfirm,
          onConfirmed: (isConfirmed) {
            if (isConfirmed) _deletePost(context, post);
          },
        );
        break;
    }
  }



  /// [PresentNoreturn, Argu, getFuture]
  Future<void> _deletePost(BuildContext context, Post post) async {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    await feedViewModel.deletePost(post, feedMode);   /// [feedModeも渡す必要: Post削除後に開く2パターン]
  }



  _openProfile(BuildContext context, User postUser) {
    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ProfileScreen(
        profileMode: postUser.userId == feedViewModel.currentUser.userId
            ? ProfileMode.MYSELF
            : ProfileMode.OTHER,
        selectedUser: postUser,
      ),
    ));
  }



}