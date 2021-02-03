import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/feed/components/sub/feed_post_header_part.dart';
import 'package:min3_minstag_ram/view/feed/components/sub/Image_from_url_part.dart';
import 'package:min3_minstag_ram/view/feed/components/sub/feed_post_likes_part.dart';
import 'package:min3_minstag_ram/view/feed/components/sub/feed_post_comments_part.dart';




class FeedPostTile extends StatelessWidget {
  final FeedMode feedMode;
  final Post post;
  FeedPostTile({this.feedMode, this.post});


  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Image.network(post.imageUrl),
    // );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FeedPostHeaderPart(),
          ImageFromUrlPart(imageUrl: post.imageUrl),
          FeedPostLikesPart(),
          FeedPostCommentsPart(),
        ],
      ),
    );
  }
}