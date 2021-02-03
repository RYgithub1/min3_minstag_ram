import 'dart:io';
import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/post/screens/enlarge_image_screen.dart';
import 'package:min3_minstag_ram/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';
import 'hero_image.dart';
import 'post_caption_input_text_field.dart';




class PostCaptionPart extends StatelessWidget {
  /// [PostCaptionOpenMode: enum: Post/Feed: データ共通場合分け]
  final PostCaptionOpenMode from;
  // final Post post;
  PostCaptionPart({@required this.from});
  // PostCaptionPart({@required this.from, this.post});


  @override
  Widget build(BuildContext context) {

    if(from == PostCaptionOpenMode.FROM_POST) {
      // final postViewModel = Provider.of<PostViewModel>(context, listen: false);
      final postViewModel = Provider.of<PostViewModel>(context);   /// [rebuild()]
      final _image = Image.file(postViewModel.imageFile);
      return ListTile(
        leading: HeroImage(
          image: _image,
          onTap: () => _displayLargeImage(context, _image),
        ),
        title: PostCaptionInputTextField(),
      );
    } else {   /// [from == PostCaptionOpenMode.FROM_FEED]
      return Container();
    }
  }


  _displayLargeImage(BuildContext context, Image image) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => EnlargeImageScreen(image: image)
    ));
  }


}