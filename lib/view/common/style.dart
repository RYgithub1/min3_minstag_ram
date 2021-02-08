/// [======== style.dart ========]
import 'package:flutter/material.dart';




/// [Font]
const TitleFont = "Billabong";
const RegularFont = "NotoSansJP-Medium";
const BoldFont = "NotoSansJP-Bold";




/// [Theme]
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  buttonColor: Colors.white24,
  primaryIconTheme: IconThemeData(color: Colors.white38),
  iconTheme: IconThemeData(color: Colors.white60),
  fontFamily: RegularFont,
  // ----------------------
);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  buttonColor: Colors.white,
  primaryIconTheme: IconThemeData(color: Colors.black26),
  iconTheme: IconThemeData(color: Colors.black87),
  fontFamily: RegularFont,
  // ----------------------
  primaryColor: Colors.grey[200],
);




/// [Login]
const loginTitleTextStyle = TextStyle(fontFamily: TitleFont, fontSize: 48.0);


/// [Post]
const postCaptionTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 14.0);
const postLocationTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 16.0);


/// [Feed]
const userCardTitleTextStyle = TextStyle(fontFamily: BoldFont, fontSize: 14.0);
const userCardSubTitleTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 12.0);


/// [Like && Comment]
const numberOfLikesTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 14.0);
const numberOfCommentsTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 12.0, color: Colors.grey);
const timeAgoTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 10.0, color: Colors.grey);
const commentNameTextStyle = TextStyle(fontFamily: BoldFont, fontSize: 12.0);
const commentContentTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 12.0);
const commentInputTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 14.0);


/// [Profile]
const profileRecordScoreTextStyle = TextStyle(fontFamily: BoldFont, fontSize: 20.0);
const profileRecordTitleTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 14.0);
const changeProfilePhotoTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 18.0, color: Colors.blueAccent);
const editProfileTitleTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 14.0);
const profileBioTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 12.0);


/// [Search]
const searchPageAppBarTitleTextStyle = TextStyle(fontFamily: RegularFont, color: Colors.grey);



