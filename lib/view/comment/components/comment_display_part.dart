import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/util/functions.dart';
import 'package:min3_minstag_ram/view/common/circle_photo.dart';
import 'package:min3_minstag_ram/view/common/comment_rich_text.dart';
import 'package:min3_minstag_ram/view/common/style.dart';




class CommentDisplayPart extends StatelessWidget {
  final GestureLongPressCallback onLongPressed; /// [コメント長押し削除featureの追加]

  final String postUserPhotoUrl;
  final String name;
  final String text;
  final DateTime postDateTime;
  CommentDisplayPart({
        @required this.postUserPhotoUrl,
        @required this.name,
        @required this.text,
        @required this.postDateTime,
        this.onLongPressed,  /// [上部キャプション表示と共用Class,,,キャプションで使用する際使わないため,no @req]
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(    /// [普通のWidgetにtap機能つけたいならInkWell]
        splashColor: Colors.cyan,
        onLongPress: onLongPressed,  /// [上部キャプション表示と共用Class,,,キャプションで使用する際使わないため,no @req]

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CirclePhoto(
              photoUrl: postUserPhotoUrl,
              isImageFromFile: false,   /// [場合分け用]
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CommentRichText(
                    name: name,
                    text: text,
                  ),
                  Text(
                    createTimeAgoString(postDateTime),
                    style: timeAgoTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}