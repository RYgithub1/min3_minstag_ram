import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/login/screens/login_screen.dart';
import 'package:min3_minstag_ram/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




class ProfileSettingPart extends StatelessWidget {
  final ProfileMode mode;
  ProfileSettingPart({this.mode});


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(   /// [本人か否か->popup内容: signOut可否]
      icon: Icon(Icons.settings),
      onSelected: (value) => _onPopupMenuSelected(context, value),
      itemBuilder: (context) {
        if (mode == ProfileMode.MYSELF) {
          return [
            PopupMenuItem(
              value: ProfileSettingMenu.THEME_CHANGE,
              child: Text(S.of(context).changeToLightTheme),
            ),
            PopupMenuItem(
              value: ProfileSettingMenu.SIGN_OUT,
              child: Text(S.of(context).signOut),
            ),
          ];
        } else {
          return [
            PopupMenuItem(
              value: ProfileSettingMenu.THEME_CHANGE,
              child: Text(S.of(context).changeToLightTheme),
            ),
          ];
        }
      },
    );
  }



  /// [PresentNoReturn, Argu]
  _onPopupMenuSelected(BuildContext context, ProfileSettingMenu selectedMenu) {
    switch(selectedMenu){   /// [FIXME: selectedMenu == ProfileSettingMenu.THEME_CHANGE??]
      case ProfileSettingMenu.THEME_CHANGE:
        break;
      case ProfileSettingMenu.SIGN_OUT:
        _signout(context);
    }
  }
  /// [FIXME:]
  void _signout(BuildContext context) async {
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    await profileViewModel.signOut();
    /// [ProfileScreenもLoginScreenも、HomeScreen上]
    /// [pushでなく、screen入れ替え: pushReplacement]
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }



}