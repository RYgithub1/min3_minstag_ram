import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/view/common/circle_photo.dart';
import 'package:min3_minstag_ram/view/common/style.dart';
import 'package:min3_minstag_ram/viewmodel/comment_view_model.dart';
import 'package:provider/provider.dart';




/// [入力欄(TextField)が変更された場合のハンドリング]
/// [ful]
class CommentInputPart extends StatefulWidget {
  final Post post;   /// [comment<->紐づくpostが必要]
  CommentInputPart({@required this.post});

  @override
  _CommentInputPartState createState() => _CommentInputPartState();
}




class _CommentInputPartState extends State<CommentInputPart> {

  // final TextEditingController _commentInputController = TextEditingController();
  final _commentInputController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _commentInputController.addListener(() {
      onCommentChanged();
    });
  }
  @override
  void dispose() {
    _commentInputController.dispose();
    super.dispose();
  }

  bool isCommentPostEnabled = false;


  @override
  Widget build(BuildContext context) {

    final cardColor = Theme.of(context).cardColor;
    final commentViewModel = Provider.of<CommentViewModel>(context);   /// [コメント記入毎に変更反映rebuildあり]
    /// [>>>>> currentUser: VMでgetter使用: (プログラムは)右から左へ、getしたものを代入]
    final commenter = commentViewModel.currentUser;

    return Card(   /// [ListTileにcolorないので、cardでwrap]
      color: cardColor,
      child: ListTile(
        leading: CirclePhoto(
          photoUrl: commenter.photoUrl,
          isImageFromFile: false,   /// [networkから取得するので場合分けfalse]
        ),

        title: TextField(
          controller: _commentInputController,
          style: commentInputTextStyle,
          decoration: InputDecoration(
            border: InputBorder.none,    /// [線消そう]
            hintText: S.of(context).addComment,
          ),
          /// [入力欄を折り返したい: "maxLines: null,"]
          maxLines: null,
        ),

        trailing: FlatButton(   /// [入力中判定: 入力時のみ、押せる&&色変わる -> 判別にbool]
          onPressed: isCommentPostEnabled
              ? () => _postComment(context, widget.post)   /// [ful: NEED "widget."]
              : null,
          child: Text(
            S.of(context).post,
            style: TextStyle(
              color: isCommentPostEnabled
                  ? Colors.blueAccent
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }



  void onCommentChanged() {
    final commentViewModel = Provider.of<CommentViewModel>(context, listen: false);
    /// [>>>>> comment: VMでpropertyを使用: (プログラムは)右から左へ、取得データをpropertyへ代入]
    commentViewModel.comment = _commentInputController.text;
    print("comm650: CommentInputPart: commentViewModel.comment: ${commentViewModel.comment}");

    /// [入力中判定: ]
    setState(() {
      if (_commentInputController.text.length > 0) {
        isCommentPostEnabled = true;
      } else {
        isCommentPostEnabled = false;
      }
    });
  }



  /// [comment<->紐づくpostが必要]
  _postComment(BuildContext context, Post post) async {
    final commentViewModel = Provider.of<CommentViewModel>(context, listen: false);
    await commentViewModel.postComment(post);
    /// [コメント投稿の処理終了後にclear]
    _commentInputController.clear();
  }
}