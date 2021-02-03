import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:min3_minstag_ram/view/common/button_with_icon.dart';
import 'package:min3_minstag_ram/view/post/screens/post_upload_screen.dart';




class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Text("PostPage"),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ButtonWithIcon(
                // onPressed: null,
                onPressed: () => _openPostUploadScreen(
                  UploadType.GALLERY,
                  context,
                ),
                iconData: FontAwesomeIcons.images,
                label: S.of(context).gallery,
              ),
              SizedBox(height: 24.0),
              ButtonWithIcon(
                // onPressed: null,
                onPressed: () => _openPostUploadScreen(
                  UploadType.CAMERA,
                  context,
                ),
                iconData: FontAwesomeIcons.camera,
                label: S.of(context).camera,
              ),
            ],
          ),
        ),
      ),
    );
  }



  /// [------ sup -----]
  _openPostUploadScreen(UploadType uploadType, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => PostUploadScreen(uploadType: uploadType),
    ));
  }



}
