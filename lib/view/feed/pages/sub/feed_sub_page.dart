import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/util/constants.dart';



class FeedSubPage extends StatelessWidget {

  final FeedMode feedMode;   /// [feedへは2パターン: constants.dart]
  FeedSubPage({@required this.feedMode});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("FeedSubPage")),
    );
  }
}