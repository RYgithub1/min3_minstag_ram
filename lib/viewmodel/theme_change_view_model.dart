import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/model/repository/theme_change_repository.dart';
import 'package:min3_minstag_ram/view/common/style.dart';




class ThemeChangeViewModel extends ChangeNotifier {
  final ThemeChangeRepository themeRepository;
  ThemeChangeViewModel({this.themeRepository});



  /// [dark/light: theme変更]
  // bool isDarkOn = true;
  /// [変更保持のためにgetできるように、getter,,,Rからのgetへ,,,setThemeも同様の流れに変更]
  bool get isDarkOn => ThemeChangeRepository.isDarkOn;

  ThemeData get selectedTheme => isDarkOn
                                  ? darkTheme   /// [get時に,darkThemeなら、darkTheme]
                                  : lightTheme;



  /// [PresentNoReturn, Argu, getFuture] && [theme変更: 時間のかかる処理]
  // void setTheme(bool bool) {
  void setTheme(bool isDark) async {
    await themeRepository.setTheme(isDark);
    // isDarkOn = isDark;
    notifyListeners();
  }


}