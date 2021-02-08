import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/login/screens/login_screen.dart';
import 'package:min3_minstag_ram/viewmodel/profile_view_model.dart';
import 'package:min3_minstag_ram/viewmodel/theme_change_view_model.dart';
import 'package:provider/provider.dart';




class ProfileSettingPart extends StatelessWidget {
  final ProfileMode mode;
  ProfileSettingPart({this.mode});


  @override
  Widget build(BuildContext context) {
    /// [Theme変更のbool]
    // final themeChangeViewModel = Provider.of<ThemeChangeViewModel>(context, listen: false);
    /// [listen: trueしないと、theme変更後、viewがrebuildされない]
    final themeChangeViewModel = Provider.of<ThemeChangeViewModel>(context);
    final isDarkOn =  themeChangeViewModel.isDarkOn;

    return PopupMenuButton(   /// [本人か否か->popup内容: signOut可否]
      icon: Icon(Icons.settings),
      // onSelected: (value) => _onPopupMenuSelected(context, value),
      onSelected: (value) => _onPopupMenuSelected(context, value, isDarkOn),
      itemBuilder: (context) {
        if (mode == ProfileMode.MYSELF) {
          return [
            PopupMenuItem(
              value: ProfileSettingMenu.THEME_CHANGE,
              /// [Theme変更のbool]
              child: isDarkOn
                  ? Text(S.of(context).changeToLightTheme)
                  : Text(S.of(context).changeToDarkTheme),
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



  /// [テーマの動的変更 && サインアウト]
  /// [PresentNoReturn, Argu]
  _onPopupMenuSelected(BuildContext context, ProfileSettingMenu selectedMenu, bool isDarkOn) {
    switch(selectedMenu){
      case ProfileSettingMenu.THEME_CHANGE:
        final themeChangeViewModel = Provider.of<ThemeChangeViewModel>(context, listen: false);
        /// [Theme変更用method()を、viewModelに作成,,,dark/light: bool]
        themeChangeViewModel.setTheme(!isDarkOn);    /// [boolゆえ反例が白黒変更]
        break;

      case ProfileSettingMenu.SIGN_OUT:
        _signout(context);
    }
  }
  /// [PresentNoReturn, Argu, getFuture]
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