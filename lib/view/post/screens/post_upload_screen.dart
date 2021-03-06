import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/common/confirm_dialog.dart';
import 'package:min3_minstag_ram/view/post/components/post_caption_part.dart';
import 'package:min3_minstag_ram/view/post/components/post_location.part.dart';
import 'package:min3_minstag_ram/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';




class PostUploadScreen extends StatelessWidget {

  final UploadType uploadType;
  PostUploadScreen({this.uploadType});


  @override
  Widget build(BuildContext context) {

    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    /// [if: 画像取得できてない&&画像処理中でない]
    if(!postViewModel.isImagePicked && !postViewModel.isProcessing) {
      Future(  () => postViewModel.pickImage(uploadType)  );   /// [build()普通に回すとエラー、Futureで逃がす]
    }

    return Consumer<PostViewModel>(
      builder: (context, model, child){
        return Scaffold(
          appBar: AppBar(
            leading: model.isProcessing
                ? Container()
                : IconButton(icon: Icon(Icons.arrow_back), onPressed: () => _cancelPost(context)),   /// [VoidCallBack: () =>, 必要]
            title: model.isProcessing
                ? Text(S.of(context).underProcessing)
                : Text(S.of(context).post),
            actions: <Widget>[
              (model.isProcessing || !model.isImagePicked)  /// [処理中||画像取得できず]
                  ? IconButton(icon: Icon(Icons.close), onPressed: () => _cancelPost(context))   /// [()=>]
                  : IconButton(icon: Icon(Icons.done), onPressed: () => showConfirmDialog(   /// [()=>: メソッド参照でない場合VoidCallBack必要]
                       /// [Dialog]
                      context: context,
                      title: S.of(context).post,
                      content: S.of(context).postConfirm,
                      onConfirmed: (isConfirmed) {
                        if (isConfirmed){
                          _post(context);
                        }
                      },
                  )),
            ],
          ),
          body: model.isProcessing
              ? Center(child: CircularProgressIndicator())
              : model.isImagePicked
                  ? Column(
                    children: <Widget>[
                      Divider(),
                      PostCaptionPart(from: PostCaptionOpenMode.FROM_POST),
                      Divider(),
                      PostLocationPart(),
                      Divider(),
                    ],
                  )
                  : Container(),
        );
      },
    );
  }



  _cancelPost(BuildContext context) {
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    postViewModel.cancelPost();   /// [NoReturnNoArgu]
    Navigator.pop(context);
  }


  void _post(BuildContext context) async {
    print("comm600: PostUploadScreen: $_post:");
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    await postViewModel.post();
    /// [終了時に画面閉じる]
    Navigator.pop(context);
  }


}