import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/profile/components/profile_detail_part.dart';
import 'package:min3_minstag_ram/view/profile/components/profile_posts_grid_part.dart';
import 'package:min3_minstag_ram/view/profile/components/profile_setting_part.dart';
import 'package:min3_minstag_ram/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




class ProfilePage extends StatelessWidget {
  final ProfileMode profileMode;
  final User selectedUser;
  ProfilePage({@required this.profileMode, @required this.selectedUser});


  @override
  Widget build(BuildContext context) {

    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    /// [CurrentUser誰かにより内容変わるので]
    profileViewModel.setProfileUser(profileMode, selectedUser);

    /// [Futureで逃がす]
    Future(  () => profileViewModel.getPost()  );


    return Scaffold(
      body: Consumer<ProfileViewModel>(
        builder: (context, model, child) {
          print("comm330: ProfilePage: ${model.posts}");
          final profileUser = model.profileUser;

          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text(profileUser.inAppUserName),
                pinned: true,
                floating: true,
                actions: <Widget>[
                  ProfileSettingPart(mode: profileMode),
                ],
                expandedHeight: 280.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: ProfileDetailPart(mode: profileMode),
                ),
              ),

              ProfilePostsGridPart(posts: model.posts),
            ],
          );
        },
      ),
    );
  }
}