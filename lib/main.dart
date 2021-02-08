import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:min3_minstag_ram/di/providers.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/model/repository/theme_change_repository.dart';
import 'package:min3_minstag_ram/view/home_screen.dart';
import 'package:min3_minstag_ram/view/login/screens/login_screen.dart';
import 'package:min3_minstag_ram/viewmodel/login_view_model.dart';
import 'package:min3_minstag_ram/viewmodel/theme_change_view_model.dart';
import 'package:provider/provider.dart';

import 'package:timeago/timeago.dart' as timeAgo;   // TopLevelFunctionで出てきてしまう -> as xxx



void main() async {
  /// [Themeh変更: VM呼びたい: BuildContext配下,,ない: 直接Rを呼ぶ]
  WidgetsFlutterBinding.ensureInitialized();
  final themeChangeRepository = ThemeChangeRepository();
  await themeChangeRepository.getIsDarkOn();


  timeAgo.setLocaleMessages("ja", timeAgo.JaMessages());    /// [TimeStamp: timeAgo]


  /// [firebase_core(ver.0.5.0以降): Distructive changes]
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    /// [theme変更: WidgetでないのでConsumer不可ゆえ定義: 変更する,,,listen: true]
    final themeChangeViewModel = Provider.of<ThemeChangeViewModel>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,

      title: 'MINSTAGRAM',
      theme: themeChangeViewModel.selectedTheme,

      // home: HomeScreen(),
      /// home: Consumer<>TA(   [Consumer vs FutureBuilder]
      home: FutureBuilder(
        future: loginViewModel.isSignIn(),
        builder: (context, AsyncSnapshot<bool> snapshot){
          /// [HINT: snapshot.data（=Firestoreのdata相当）  ||  .docsARRAY.data()（=纏まったデータ）]
          if (snapshot.hasData && snapshot.data){   /// [データあり&&データがtrue->ログイン中へ進む]
            return HomeScreen();
          } else {   /// [そうでなければログイン処理へ進む]
            return LoginScreen();
          }
        },
      ),
    );
  }
}
