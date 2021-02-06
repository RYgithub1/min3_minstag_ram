import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/feed/components/sub/image_from_url_part.dart';
import 'package:min3_minstag_ram/view/feed/screens/feed_screen.dart';
import 'package:min3_minstag_ram/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




class ProfilePostsGridPart extends StatelessWidget {
  final List<Post> posts;
  ProfilePostsGridPart({@required this.posts});


  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      children: posts.isEmpty
          ? [Container()]    /// [children: ゆえ]
          : List.generate(   /// [List型で作成ゆえ【】不要]
            posts.length,
            (int index) => InkWell(
              onTap: () => _openFeedScreen(context, index),
              child: ImageFromUrlPart(imageUrl: posts[index].imageUrl)),
          ),
    );
  }



  /// [PresentNoReturn, Argu]
  _openFeedScreen(BuildContext context, int index) {
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final feedUser = profileViewModel.profileUser;

    Navigator.push(context, MaterialPageRoute(
      builder: (_) => FeedScreen(
        feedUser: feedUser,
        index: index,
        feedMode: FeedMode.FROM_PROFILE,
      ),
    ));
  }



}