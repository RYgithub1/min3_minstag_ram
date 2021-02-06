import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/view/common/circle_photo.dart';
import 'package:min3_minstag_ram/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final profileUser = profileViewModel.profileUser;

    return CirclePhoto(
      photoUrl: profileUser.photoUrl,   /// [profileのユーザのphoto欲しい: ProfileViewModel]
      isImageFromFile: false,
      radius: 30.0,
    );
  }
}