import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';




class CirclePhoto extends StatelessWidget {
  final String photoUrl;   /// [ネットワーク画像]
  final double radius;
  final bool isImageFromFile;   /// [ローカル端末からの画像の場合もあり場合分けbool]
  /// [欲しいデータをconstructする]
  CirclePhoto({@required this.photoUrl,  this.radius, @required this.isImageFromFile});


  @override
  Widget build(BuildContext context) {
    return CircleAvatar(    /// [画像を丸くしたいなら]
      radius: radius,
      backgroundImage: isImageFromFile
          ? FileImage(File(photoUrl))
          : CachedNetworkImageProvider(photoUrl),
    );
  }
}