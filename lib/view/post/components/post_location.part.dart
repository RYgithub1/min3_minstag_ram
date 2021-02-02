import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:min3_minstag_ram/data_models/location.dart';
import 'package:min3_minstag_ram/generated/l10n.dart';
import 'package:min3_minstag_ram/view/common/style.dart';
import 'package:min3_minstag_ram/viewmodel/post_view_model.dart';
import 'package:provider/provider.dart';




class PostLocationPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    final postViewModel = Provider.of<PostViewModel>(context);   /// [rebuild対象]

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          postViewModel.locationString,
          style: postLocationTextStyle,
        ),
        subtitle: _latLngPart(postViewModel.location, context),
        trailing: IconButton(
          icon: FaIcon(FontAwesomeIcons.mapMarkerAlt),
          onPressed: null,
        ),
      ),
    );
  }



  _latLngPart(Location location, BuildContext context) {
    const spaceWidth = 8.0;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Chip(
          label: Text(S.of(context).latitude),
        ),
        SizedBox(width: spaceWidth),
        Text(location.latitude.toStringAsFixed(2)),  /// [.toStringAsFixed(2): 小数2]
        SizedBox(width: spaceWidth),
        Chip(
          label: Text(S.of(context).longitude),
        ),
        SizedBox(width: spaceWidth),
        Text(location.longitude.toStringAsFixed(2)),
      ],
    );
  }


}