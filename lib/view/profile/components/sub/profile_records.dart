import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/common/style.dart';
import 'package:min3_minstag_ram/view/who_cares_me/who_cares_me_screen.dart';
import 'package:min3_minstag_ram/viewmodel/profile_view_model.dart';
import 'package:provider/provider.dart';




class ProfileRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);   /// [InfinitNotifyLoop: FutureBuilderで逃がす]

    return Row(
      children: <Widget>[
        // _userRecordWidget(
        //   context: context,
        //   score: 11,
        //   title: S.of(context).post,
        // ),
        /// [InfinitNotifyLoop: FutureBuilderで逃がす]
        FutureBuilder(
          future: profileViewModel.getNumberOfPost(),
          builder: (context, AsyncSnapshot<int> snapshot){
            return _userRecordWidget(
              context: context,
              score: snapshot.hasData
                  ? snapshot.data
                  : 0,
              title: S.of(context).post,
            );
          },
        ),
        // _userRecordWidget(
        //   context: context,
        //   score: 7,
        //   title: S.of(context).followers
        // ),
        FutureBuilder(
          future: profileViewModel.getNumberOfFollowers(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return _userRecordWidget(
              context: context,
              score: snapshot.hasData
                  ? snapshot.data
                  : 0,
              title: S.of(context).followers,
              /// [WhoCaresMe]
              whoCaresMeMode: WhoCaresMeMode.FOLLOWED,
            );
          },
        ),
        // _userRecordWidget(
        //   context: context,
        //   score: 6,
        //   title: S.of(context).followings,
        // ),
        FutureBuilder(
          future: profileViewModel.getNumberOfFollowings(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return _userRecordWidget(
              context: context,
              score: snapshot.hasData
                  ? snapshot.data
                  : 0,
              title: S.of(context).followings,
              /// [WhoCaresMe]
              whoCaresMeMode: WhoCaresMeMode.FOLLOWING,
            );
          },
        ),
      ],
    );
  }



  /// [PresentNoReturn, Argu]
  // _userRecordWidget(BuildContext context, int score, String title) {
  _userRecordWidget({BuildContext context, int score, String title, WhoCaresMeMode whoCaresMeMode}) {   /// [可読性: {名前付きargu}に変更]
    return Expanded(
      flex: 1,   /// [DEFAUT: "int flex = 1,": 書かなくても良いが明記]
      child: GestureDetector(   /// [WhoCaresMe]
        onTap: whoCaresMeMode == null
            ? null
            : () => _checkFollowUsers(context, whoCaresMeMode),

        child: Column(
          children: <Widget>[
            Text(
              score.toString(),
              style: profileRecordScoreTextStyle,
            ),
            Text(
              title.toString(),
              style: profileRecordTitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }



  _checkFollowUsers(BuildContext context, WhoCaresMeMode whoCaresMeMode) {
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    final profileUser = profileViewModel.profileUser;
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => WhoCaresMeScreen(
        mode: whoCaresMeMode,
        id: profileUser.userId,
      ),
    ));
  }


}