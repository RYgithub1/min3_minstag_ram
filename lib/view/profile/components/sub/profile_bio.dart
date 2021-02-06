import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/common/style.dart';
import 'package:min3_minstag_ram/view/profile/screens/edit_profile_screen.dart';
import 'package:min3_minstag_ram/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




class ProfileBio extends StatelessWidget {

  final ProfileMode mode;
  ProfileBio({@required this.mode});   /// [profile: 自分のなら編集権限, 他人のならフォローボタン]


  @override
  Widget build(BuildContext context) {

    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);   /// [userの名前欲しい為]
    final profileUser = profileViewModel.profileUser;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(profileUser.inAppUserName),
          // Text("baio"),
          Text(
            profileUser.bio,
            style: profileBioTextStyle,
          ),
          SizedBox(height: 16.0),
          SizedBox(   /// [ボタンを横幅最大にしたい=SizedBoxでwrapしてinfinity]
            width: double.infinity,
            child: _button(context, profileUser),
          ),
        ],
      ),
    );
  }



  /// [child: xxx  -> WidgetのReturn必要]
  /// [PresentWidgetreturn, Argu]
  _button(BuildContext context, User profileUser) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: mode == ProfileMode.MYSELF
          ? Text(S.of(context).editProfile)
          : Text("follow"),
      onPressed: () => _openEditProfileScreen(context),
    );
  }



  /// [PresentNoReturn, Argu]
  _openEditProfileScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => EditProfileScreen(),
    ));
  }


}