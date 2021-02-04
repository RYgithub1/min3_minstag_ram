import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';



class ImageFromUrlPart extends StatelessWidget {
  final String imageUrl;
  ImageFromUrlPart({this.imageUrl});


  @override
  Widget build(BuildContext context) {
    // return Center(child: Container(child: Image.network(imageUrl)));
    /// [画像なく投稿 == nullの場合のハンドリング]
    if (imageUrl == null) {
      return const Icon(Icons.broken_image);
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        /// [Flutter1.22update202010: 画像がフィットしないissue: fit]
        fit: BoxFit.cover,
      );
    }
  }
}