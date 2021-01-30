import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/model/repository/post_repository.dart';
import 'package:min3_minstag_ram/model/repository/user_repository.dart';




class PostViewModel extends ChangeNotifier {

  final PostRepository postRepository;
  final UserRepository userRepository;   /// [post-user: 紐づく]
  PostViewModel({this.postRepository, this.userRepository});

  bool isProcessing = false;   /// [false: 処理中ではない]
  bool isImagePicked = false;   /// [false: 画像取得できなかった]




}