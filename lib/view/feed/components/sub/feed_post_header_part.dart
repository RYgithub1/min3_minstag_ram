import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/common/user_card.dart';




class FeedPostHeaderPart extends StatelessWidget {
  final User postUser;
  final Post post;
  final User currentUser;
  /// [投稿ユーザーの情報があればよい...subTitleは投稿時の場所post...本人の投稿かで可能なcrud変わるcurrentUser]
  FeedPostHeaderPart({@required this.postUser, @required this.post, @required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return UserCard(
      onTap: null,
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



  _onPopupMenuSelected(BuildContext context, value) {}
}