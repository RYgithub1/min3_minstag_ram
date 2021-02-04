import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/util/functions.dart';
import 'package:min3_minstag_ram/view/common/circle_photo.dart';
import 'package:min3_minstag_ram/view/common/comment_rich_text.dart';
import 'package:min3_minstag_ram/view/common/style.dart';




class CommentDisplayPart extends StatelessWidget {
  final String postUserPhotoUrl;
  final String name;
  final String text;
  final DateTime postDateTime;
  CommentDisplayPart({
        @required this.postUserPhotoUrl,
        @required this.name,
        @required this.text,
        @required this.postDateTime,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}