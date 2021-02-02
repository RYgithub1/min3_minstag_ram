import 'dart:io';
import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/location.dart';
import 'package:min3_minstag_ram/model/repository/post_repository.dart';
import 'package:min3_minstag_ram/model/repository/user_repository.dart';
import 'package:min3_minstag_ram/util/constants.dart';




class PostViewModel extends ChangeNotifier {

  final PostRepository postRepository;
  final UserRepository userRepository;   /// [post-user: 紐づく]
  PostViewModel({this.postRepository, this.userRepository});

  bool isProcessing = false;   /// [false: 処理中ではない]
  bool isImagePicked = false;   /// [false: 画像取得できなかった]

  File imageFile;   /// [R->VM: 結果取得 -> notify用]

  Location location;
  String locationString = "";

  String caption;



  Future<void> pickImage(UploadType uploadType) async {
    isImagePicked = false;
    isProcessing =  true;
    notifyListeners();

    imageFile = await postRepository.pickImage(uploadType);
    print("comm001: PostViewModel: pickImage: ${imageFile.path}");


    location = await postRepository.getCurrentLocation();
    /// [location格納用の作成]
    locationString = _toLocationString(location);
    print("comm002: locationString: $locationString");




    /// [取得できていればtrue]
    if(imageFile != null) isImagePicked = true;
    isProcessing =  false;
    notifyListeners();


  }




  String _toLocationString(Location location) {
    return location.country + " " + location.state + " " + location.city;
  }


}