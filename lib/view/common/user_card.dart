import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/view/common/style.dart';
import 'circle_photo.dart';




class UserCard extends StatelessWidget {
  final VoidCallback onTap;
  final String photoUrl;
  final String title;
  final String subTitle;
  final Widget trailing;
  /// [クリックレスポInkWell]
  UserCard({
    @required this.onTap,
    @required this.photoUrl,
    @required this.title,
    @required this.subTitle,
    this.trailing,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueGrey,
      onTap: onTap,
      child: ListTile(
        // leading: CirclePhoto(photoUrl: photoUrl),
        leading: CirclePhoto(
          photoUrl: photoUrl,
          /// [場合分け<bool>isImageFromFile渡す必要: ローカル端末からCirclePhoto()]
          isImageFromFile: false,
        ),
        title: Text(
          title,
          style: userCardTitleTextStyle,
        ),
        subtitle: Text(
          subTitle,
          style: userCardSubTitleTextStyle,
        ),
        trailing: trailing,
      )
    );
  }
}