import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/post/screens/enlarge_image_screen.dart';
import 'package:min3_minstag_ram/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';
import 'hero_image.dart';




class PostCaptionPart extends StatelessWidget {
  /// [PostCaptionOpenMode: enum: Post/Feed: データ共通場合分け]
  final PostCaptionOpenMode from;
  PostCaptionPart({@required this.from});


  @override
  Widget build(BuildContext context) {

    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    final _image = Image.file(postViewModel.imageFile);

    if(from == PostCaptionOpenMode.FROM_POST) {
      return ListTile(
        leading: HeroImage(
          image: _image,
          onTap: () => _displayLargeImage(context, _image),
        ),
        // title: PostCaptionInputTextField(),
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