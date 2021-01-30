import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/util/constants.dart';
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

    return Scaffold(
      body: Container(),
    );
  }
}