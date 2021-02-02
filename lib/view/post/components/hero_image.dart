import 'dart:ui';
import 'package:flutter/material.dart';




class HeroImage extends StatelessWidget {

  final Image image;
  final VoidCallback onTap;
  HeroImage({this.image, this.onTap});


  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "postImage",   /// [ポ: 受け渡し両側で同じtag指定]
      child: InkWell(
        onTap: onTap,
        child: image,
      ),
    );
  }
}