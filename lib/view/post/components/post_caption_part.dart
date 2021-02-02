import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/util/constants.dart';




class PostCaptionPart extends StatelessWidget {
  /// [PostCaptionOpenMode: enum: Post/Feed: データ共通場合分け]
  final PostCaptionOpenMode from;
  PostCaptionPart({@required this.from});


  @override
  Widget build(BuildContext context) {
    if(from == PostCaptionOpenMode.FROM_POST) {
      return ListTile(
        leading: HeroImage(),
        title: PostCaptionInputTextField(),
      );
    } else {   /// [from == PostCaptionOpenMode.FROM_FEED]
      return Container();
    }


  }
}