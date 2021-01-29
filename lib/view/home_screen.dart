import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';



class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("home screen"),
          Text(S.of(context).appTitle),
          Icon(Icons.add),
          
        ],
      ),
    );
  }
}