import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/common/style.dart';
import 'package:min3_minstag_ram/view/profile/screens/profile_screen.dart';
import 'package:min3_minstag_ram/view/search/components/search_user_delegate.dart';




/// [SearchDelegate: ]
class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: InkWell(    /// [タイトルを検索barにして、押下感]
          splashColor: Colors.white30,
          onTap: () => _searchuser(context),
          child: Text(
            S.of(context).search,
            style: searchPageAppBarTitleTextStyle,
          ),
        ),
      ),
      body: Center(
        child: Text("SearchPage"),
      ),
    );
  }



  /// [PresentNoreturn, NoArgu]
  _searchuser(BuildContext context) async{
    final selectedUser = await showSearch(
      context: context,
      delegate: SearchUserDelegate(),  /// [SearchUserDelegate(): 作成したDelegateクラスに飛ばす]
    );
    /// [ユーザー検索結果を受けた処理]
    if (selectedUser != null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => ProfileScreen(
          profileMode: ProfileMode.OTHER,
          selectedUser: selectedUser,
        ),
      ));
    }
  }



}