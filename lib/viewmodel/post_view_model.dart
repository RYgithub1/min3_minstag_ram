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

  // String caption;
  String caption ="";



  Future<void> pickImage(UploadType uploadType) async {
    isImagePicked = false;
    isProcessing = true;
    notifyListeners();

    imageFile = await postRepository.pickImage(uploadType);
    print("comm301: PostViewModel: pickImage: ${imageFile.path}");

    location = await postRepository.getCurrentLocation();
    print("comm302: PostViewModel: pickImage: ${imageFile.path}");
    /// [location格納用の作成]
    locationString = _toLocationString(location);
    print("comm303: locationString: $locationString");

    /// [取得できていればtrue]
    if (imageFile != null) isImagePicked = true;
    isProcessing = false;
    notifyListeners();
  }


  /// [method(){}]
  String _toLocationString(Location location) {
    return location.country + " " + location.state + " " + location.city;
  }



  /// [FutureNoReturn(NL), Argu]
  Future<void> updateLocation(double latitude, double longitude) async {
    /// [locationをアップデートする]
    location = await postRepository.updateLocation(latitude, longitude);
    /// [locationアップデート後にlocationString更新]
    locationString = _toLocationString(location);
    notifyListeners();
  }




  /// [FutureNoReturn(NL), Argu]
  Future<void> post() async {
    isProcessing = true;
    notifyListeners();
    /// [渡したい物を追記する]
    await postRepository.post(
      UserRepository.currentUser,
      imageFile,
      caption,
      location,
      locationString,
    );
    /// [Upload終わったら]
    isProcessing = false;
    isImagePicked = false;
    notifyListeners();
  }




  /// [PresentNoReturn(NL), NoArgu]
  /// [Circularの停止]
  void cancelPost() {
    isProcessing = false;
    isImagePicked = false;
    notifyListeners();
  }


}