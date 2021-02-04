import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/feed/components/sub/feed_post_header_part.dart';
import 'package:min3_minstag_ram/view/feed/components/sub/Image_from_url_part.dart';
import 'package:min3_minstag_ram/view/feed/components/sub/feed_post_likes_part.dart';
import 'package:min3_minstag_ram/view/feed/components/sub/feed_post_comments_part.dart';
import 'package:min3_minstag_ram/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';




class FeedPostTile extends StatelessWidget {
  final FeedMode feedMode;
  final Post post;
  FeedPostTile({this.feedMode, this.post});


  @override
  Widget build(BuildContext context) {

    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      /// [無限ループを避けるため(非同期処理後にbuilder): FutureBuilder]
      /// [FeedSubPage()/Consumer()/notify->rebuild==newFIX->notify->...INFINIT]
      child: FutureBuilder(
        future: feedViewModel.getPostUserInfo(post.userId),
        builder: (context, AsyncSnapshot<User> snapshot) {
          /// [データが存在し、かつnullでない(ここでdataの中身実質user)]
          if (snapshot.hasData && snapshot.data != null) {
            final postUser = snapshot.data;
            final currentUser = feedViewModel.currentUser;
            print("comm110: FeedPostTile: postUser: $postUser");
            print("comm111: FeedPostTile: currentUser: $currentUser");
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // FeedPostHeaderPart(postUser: postUser, post: post, currentUser: currentUser, feedMode: feedMode),
                FeedPostHeaderPart(postUser: postUser, post: post, currentUser: currentUser),
                ImageFromUrlPart(imageUrl: post.imageUrl),
                FeedPostLikesPart(),
                FeedPostCommentsPart(postUser: postUser, post: post),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
