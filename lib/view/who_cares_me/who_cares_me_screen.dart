import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/common/user_card.dart';
import 'package:min3_minstag_ram/view/profile/screens/profile_screen.dart';
import 'package:min3_minstag_ram/viewmodel/who_cares_me_view_model.dart';
import 'package:provider/provider.dart';




/// [3パターンからアクセス]
class WhoCaresMeScreen extends StatelessWidget {
  final WhoCaresMeMode mode;
  final String id;
  WhoCaresMeScreen({@required this.mode, @required this.id});


  @override
  Widget build(BuildContext context) {
    final whoCaresMeViewModel = Provider.of<WhoCaresMeViewModel>(context, listen: false);
    /// [buildエラーになるので、Futureで逃がす]
    Future(  () => whoCaresMeViewModel.getCaresMeUsers(id, mode)  );


    return Scaffold(
      appBar: AppBar(
        // title: Text(S.of(context).)
        title: Text(_titleText(context, mode)),
      ),

      body: Consumer<WhoCaresMeViewModel>(
        builder: (_, model, child) {
          return model.caresMeUsers.isEmpty
              ? Container()
              : ListView.builder(
                itemCount: model.caresMeUsers.length,
                itemBuilder: (context, int index) {
                  final user = model.caresMeUsers[index];
                  return UserCard(
                    photoUrl: user.photoUrl,
                    title: user.inAppUserName,
                    subTitle: user.bio,
                    // onTap: _openProfileScreen(context, user),
                    onTap: () => _openProfileScreen(context, user),
                  );
                },
              );
        },
      ),
    );
  }



  /// [PresentStringReturn, Argu]
  String _titleText(BuildContext context, WhoCaresMeMode mode) {
    var titelText = "";
    switch (mode) {
      case WhoCaresMeMode.LIKE:
        titelText = S.of(context).likes;
        break;
      case WhoCaresMeMode.FOLLOWED:
        titelText = S.of(context).followers;
        break;
      case WhoCaresMeMode.FOLLOWING:
        titelText = S.of(context).followings;
        break;
      default:
        print('Default: no matching case');
        break;
    }
    return titelText;
  }



  /// [PresentNoReturn, Argu]
  _openProfileScreen(BuildContext context, User user) {
    final whoCaresMeViewModel = Provider.of<WhoCaresMeViewModel>(context, listen: false);
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => ProfileScreen(
        /// [viewModelにcurrentUser用意しておく]
        profileMode: user.userId == whoCaresMeViewModel.currentUser.userId
            ? ProfileMode.MYSELF
            : ProfileMode.OTHER,
        selectedUser: user,
      ),
    ));
  }
}