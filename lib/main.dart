import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';

import 'package:min3_minstag_ram/screens/home_screen.dart';
import 'package:min3_minstag_ram/style.dart';




void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      home: HomeScreen(),
    );
  }
}
