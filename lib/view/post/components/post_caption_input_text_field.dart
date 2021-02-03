import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/common/style.dart';
import 'package:min3_minstag_ram/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';




class PostCaptionInputTextField extends StatefulWidget {
  /// [caption dataをpassするのに必要]
  final String captionBeforeUpdated;
  final PostCaptionOpenMode from;
  PostCaptionInputTextField({this.captionBeforeUpdated, this.from});

  @override
  _PostCaptionInputTextFieldState createState() => _PostCaptionInputTextFieldState();
}




class _PostCaptionInputTextFieldState extends State<PostCaptionInputTextField> {

  final _captionController = TextEditingController();   /// [実はChnageNotifier: addListener()]
  @override
  void initState() {
    super.initState();
    _captionController.addListener(() {   /// [実はChnageNotifier: addListener()]
      _onCaptionUpdated();
    });
  }
  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _captionController,
      style: postCaptionTextStyle,
      autofocus: true,   /// [focus]
      keyboardType: TextInputType.multiline,   /// [複数行]
      maxLines:  null,   /// [no max]
      decoration: InputDecoration(
        hintText: S.of(context).inputCaption,
        border: InputBorder.none,
      ),
    );
  }



  _onCaptionUpdated() {
    final viewModel = Provider.of<PostViewModel>(context, listen:false);
    viewModel.caption = _captionController.text;
    print("comm100: _onCaptionUpdated: ${viewModel.caption}");
  }


}