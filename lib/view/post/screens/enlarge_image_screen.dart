import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/view/post/components/hero_image.dart';




/// [Hero拡大時用UI]
class EnlargeImageScreen extends StatelessWidget {

  final Image image;
  EnlargeImageScreen({this.image});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: HeroImage(
          image: image,
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}