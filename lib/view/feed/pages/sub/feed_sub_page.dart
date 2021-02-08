import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/feed/components/feed_post_tile.dart';
import 'package:min3_minstag_ram/viewmodel/feed_view_model.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';




class FeedSubPage extends StatelessWidget {

  final FeedMode feedMode;   /// [feedへは2パターン: constants.dart]
  final User feedUser;
  final int index;
  FeedSubPage({@required this.feedMode, this.feedUser, @required this.index});


  @override
  Widget build(BuildContext context) {

    final feedViewModel = Provider.of<FeedViewModel>(context, listen: false);
    /// feedViewModel.setFeedUser(feedMode, null);   [profile画面からの遷移は、feedUser]
    feedViewModel.setFeedUser(feedMode, feedUser);
    Future(  () => feedViewModel.getPosts(feedMode)  );   /// [method(feedMode): 2パターンのため]

    return Consumer<FeedViewModel>(
      builder: (context, model, child) {
        if (model.isProcessing) {
          return Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(   /// [スクロールリロード]
            onRefresh: () => feedViewModel.getPosts(feedMode),   /// [VM更新するだけ(notify走る)]
            /// child: ListView.builder(    /// [Scroll先が選んだimage: scrollable_positioned_list]
            child: ScrollablePositionedList.builder(
              initialScrollIndex: index,
              physics: AlwaysScrollableScrollPhysics(),   /// [スクロールリロード: RefreshIndicator()]

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
            ),
          );
        }
      },
    );
  }
}