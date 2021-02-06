import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/profile/components/sub/profile_bio.dart';
import 'package:min3_minstag_ram/view/profile/components/sub/profile_image.dart';
import 'package:min3_minstag_ram/view/profile/components/sub/profile_records.dart';




class ProfileDetailPart extends StatelessWidget {
  final ProfileMode mode;
  ProfileDetailPart({@required this.mode});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ProfileImage(),
              ),
              Expanded(
                flex: 3,
                child: ProfileRecords(),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          ProfileBio(mode: mode),
        ],
      ),
    );
  }
}