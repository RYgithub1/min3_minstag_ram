import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:min3_minstag_ram/di/providers.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';

import 'package:min3_minstag_ram/view/common/style.dart';
import 'package:min3_minstag_ram/view/home_screen.dart';
import 'package:min3_minstag_ram/view/login/screens/login_screen.dart';
import 'package:min3_minstag_ram/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';




void main() async {
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
      theme: ThemeData(
        brightness: Brightness.dark,
        buttonColor: Colors.white24,
        primaryIconTheme: IconThemeData(color: Colors.white38),
        iconTheme: IconThemeData(color: Colors.white60),
        fontFamily: RegularFont,
      ),

      // home: HomeScreen(),
      /// home: Consumer<>TA(   [Consumer vs FutureBuilder]
      home: FutureBuilder(
        future: loginViewModel.isSignIn(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if(snapshot.hasData && snapshot.data) {   /// [データあり&&データがtrue->ログイン中へ進む]
            return HomeScreen();
          } else {   /// [そうでなければログイン処理へ進む]
            return LoginScreen();
          }
        },
      ),
    );
  }
}
