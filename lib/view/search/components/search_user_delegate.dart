import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/view/common/user_card.dart';
import 'package:min3_minstag_ram/viewmodel/search_view_model.dart';
import 'package:provider/provider.dart';




/// [extends SearchDelegate<検索対象Type>]
/// [Titleで検索]
class SearchUserDelegate extends SearchDelegate<User> {
  /// [appBarは手動追加: デフォルト白いのでdartk]
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      brightness: Brightness.dark,
    );
  }




  /// [（自動）AppBar/leading属性と同じ]
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      // onPressed: () => close(context, null),
      onPressed: () {    /// [検索画面閉じるメソッド]
        print("comm550: SearchUserDelegate: buildLeading:");
        close(context, null);
      },
    );
  }


  /// [（自動）AppBar/action属性と同じ]
  @override
  List<Widget> buildActions(BuildContext context) {
    /// [F12(SearchDelegate) -> Title は _queryTextController]
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          print("comm551: SearchUserDelegate: buildActions:");
          query = "";
        },
      ),
    ];
  }


  /// [（自動）検索処理 中に表示]
  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildResult(context);
  }
  /// [（自動）検索処理 後に表示]
  @override
  Widget buildResults(BuildContext context) {
    return _buildResult(context);
  }




  /// [============== 検索メソッド ==============]
  /// [PresentWidgetReturn, Argu]
  Widget _buildResult(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
    /// [abstract class SearchDelegate<T> {} でgetter定義されている query を利用]
    searchViewModel.searchUsers(query);

    return ListView.builder(
      itemCount: searchViewModel.soughtUsers.length,
      itemBuilder: (context, int index) {
        final user = searchViewModel.soughtUsers[index];
        return UserCard(
          onTap: () {
            close(context, user);
          },
          photoUrl: user.photoUrl,
          title: user.inAppUserName,
          subTitle: user.bio,
        );
      });
  }



}