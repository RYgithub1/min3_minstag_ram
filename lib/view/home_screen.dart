import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'activity/pages/activity_page.dart';
import 'feed/pages/feed_page.dart';
import 'post/pages/post_page.dart';
import 'profile/pages/profile.page.dart';
import 'search/pages/search_page.dart';




class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}




class _HomeScreenState extends State<HomeScreen> {
  // final List<Widget> _currentPages = [];
  /// [final: state変化出来ずerror(ex. initiState())]
  List<Widget> _currentPages = [];
  @override
  void initState() {
    super.initState();
    _currentPages = [
      FeedPage(),
      SearchPage(),
      PostPage(),
      ActivityPage(),
      ProfilePage(profileMode: ProfileMode.MYSELF, selectedUser: null,),
    ];
  }
  // final int _currentIndex = 0;
  /// ['_currentIndex' can't be used as a setter because it's final.]
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(child: Text("home screen")),
      body: _currentPages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.search),
            label: S.of(context).search,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.plusSquare),
            label: S.of(context).add,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart),
            label: S.of(context).activities,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.user),
            label: S.of(context).user,
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        fixedColor: Colors.blueAccent,
        type: BottomNavigationBarType.fixed,   /// [to fix]
        showSelectedLabels: false,   /// [no letter for selected]
        showUnselectedLabels: false,   /// [no letter for unselected]
      ),
    );
  }
}
