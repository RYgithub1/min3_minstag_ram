import 'package:flutter/material.dart';



class ImageFromUrlPart extends StatelessWidget {
  final String imageUrl;
  ImageFromUrlPart({this.imageUrl});


  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Image.network(imageUrl)));
  }
}