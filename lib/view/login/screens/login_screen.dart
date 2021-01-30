import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/view/common/button_with_icon.dart';
import 'package:min3_minstag_ram/view/common/style.dart';
import 'package:min3_minstag_ram/view/home_screen.dart';
import 'package:min3_minstag_ram/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';




class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LoginViewModel>(
          builder: (context, model, child) {
            return model.isLoading
            ? CircularProgressIndicator()
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Login screen"),
                Text(
                  S.of(context).appTitle,
                  style: loginTitleTextStyle,
                ),
                SizedBox(height: 16.0),
                ButtonWithIcon(
                  /// onPressed: (_) => login(context),   /// [ValueChanged引数有: dynamic指定可]
                  onPressed: () => login(context),   /// [VoidCallback引数無し: dynamic指定不可]
                  iconData: FontAwesomeIcons.signInAlt,
                  label: S.of(context).signIn,  /// [Ja/En対応]
                ),
              ],
            );
          },
        ),
      ),
    );
  }



  /// [--------- sup ---------]
  login(BuildContext context) async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    await loginViewModel.signIn();
    if(!loginViewModel.isSuccessful) {    /// [ログイン処理の返り値がfalse,ログイン出来なかった場合]
      Toast.show(S.of(context).signInFailed, context);
      return;
    }
    _openHomeScreen(context);
  }
  void _openHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
    );
  }



}