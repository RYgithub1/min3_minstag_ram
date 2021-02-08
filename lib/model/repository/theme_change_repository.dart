import 'package:shared_preferences/shared_preferences.dart';




/// []
const PREF_KEY = "isDarkOn";




class ThemeChangeRepository {
  // final ThemeChangeRepository themeRepository;
  // ThemeChangeRepository({this.themeRepository});



  static bool isDarkOn = false;



  /// [FutureNoReturn, Argu]
  // Future<void> setTheme(bool isDarkOn) async {
  Future<void> setTheme(bool isDark) async {
    /// [chared_preference: db(Moor/Firestore系: Rに記述)]
    final prefs = await SharedPreferences.getInstance();

    // prefs.setBool(PREF_KEY, isDarkOn);
    await prefs.setBool(PREF_KEY, isDark);
    isDarkOn = isDark;
  }


  /// [Theme変更の保持]
  /// [FutureNoReturn, Argu]
  Future<void> getIsDarkOn() async {
    /// [SharePre呼ぶのはこの1行,同じ]
    final prefs = await SharedPreferences.getInstance();
    /// [xxx ?? "nullTrue値がない時"]
    isDarkOn = prefs.getBool(PREF_KEY) ?? true;   /// [なかったら黒にしとく]
  }


}