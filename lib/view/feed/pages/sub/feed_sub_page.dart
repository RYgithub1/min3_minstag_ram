import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/util/constants.dart';
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

    return Scaffold(
      body: Center(child: Text("FeedSubPage")),
    );
  }
}