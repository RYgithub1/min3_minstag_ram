import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/profile/pages/profile.page.dart';




class ProfileScreen extends StatelessWidget {
  final ProfileMode profileMode;
  final User selectedUser;
  ProfileScreen({@required this.profileMode, @required this.selectedUser});


  @override
  Widget build(BuildContext context) {
    return ProfilePage(     /// [ProfilePage()でScaffold: ここでは不要]
      profileMode: profileMode,
      selectedUser: selectedUser,
    );
  }
}