import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/feed/pages/sub/feed_sub_page.dart';




class FeedScreen extends StatelessWidget {
  final User feedUser;
  final int index;
  final FeedMode feedMode;
  /// [userのデータ、index、どこから開いたか情報、は欲しい]
  FeedScreen({@required this.feedUser, @required this.index, @required this.feedMode});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).post),
      ),
      body: FeedSubPage(
        feedMode: feedMode,
        feedUser: feedUser,
        index: index,
      ),
    );
  }
}