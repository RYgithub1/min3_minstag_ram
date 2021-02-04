import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/view/common/style.dart';




/// [full: Richかつクリックで開く]
class CommentRichText extends StatefulWidget {
  final String name;
  final String text;
  CommentRichText({@required this.name, @required this.text});

  @override
  _CommentRichTextState createState() => _CommentRichTextState();
}




class _CommentRichTextState extends State<CommentRichText> {

  /// [longComment折返し表示: GestureDetectorとsetState]
  int _maxLines = 2;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(  /// [longComment折返し表示: GestureDetectorとsetState]
      onTap: () {
        setState(() {
          _maxLines = 100;
        });
      },
      child: RichText(
        // maxLines: 2,
        maxLines: _maxLines,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,  /// [必須: Rich以外のDefault定義]
          children: [
            TextSpan(
              text: widget.name,
              style: commentNameTextStyle
            ),
            TextSpan(text: " "),
            TextSpan(
              text: widget.text,
              style: commentContentTextStyle
            ),
          ]
        ),
      ),
    );
  }
}