import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/feed/components/feed_post_tile.dart';
import 'package:min3_minstag_ram/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';



class FeedSubPage extends StatelessWidget {

  final FeedMode feedMode;   /// [feedへは2パターン: constants.dart]
  FeedSubPage({@required this.feedMode});


  @override
  Widget build(BuildContext context) {

    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    feedViewModel.setFeedUser(feedMode, null);
    Future(  () => feedViewModel.getPosts(feedMode)  );   /// [feedMode: 2パターンのため]

    return Consumer<FeedViewModel>(
      builder: (context, model, child) {
        if (model.isProcessing) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: model.posts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: FeedPostTile(
                  feedMode: feedMode,
                  post: model.posts[index],
                ),
              );
            },
          );
        }
      },
    );
  }
}