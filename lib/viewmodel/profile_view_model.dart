import 'package:flutter/material.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/model/repository/post_repository.dart';
import 'package:min3_minstag_ram/model/repository/user_repository.dart';
import 'package:min3_minstag_ram/util/constants.dart';


class ProfileViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  ProfileViewModel({this.userRepository, this.postRepository});



  User profileUser;   /// [ユーザー別にコンテンツ変える]
  User get currentUser => UserRepository.currentUser;

  bool isProcessing = false;
  List<Post> posts = [];



  /// [PresentNoReturn, Argu]
  void setProfileUser(ProfileMode profileMode, User selectedUser) {
    if (profileMode == ProfileMode.MYSELF) {
      profileUser = currentUser;
    } else {
      profileUser = selectedUser;
    }
    
  }



  /// [FutureNoReturn(nL), NoArgu]
  Future<void> getPost() async {
    isProcessing = true;
    notifyListeners();
    posts = await postRepository.getPosts(FeedMode.FROM_PROFILE, profileUser);
    isProcessing = false;
    notifyListeners();
  }



  /// [FutureNoReturn(nL), NoArgu]
  Future<void> signOut() async {
    await userRepository.signOut();
    notifyListeners();
  }



  /// [FutureIntReturn, NoArgu]
  Future<int> getNumberOfPost() async {
    final posts = await postRepository.getPosts(FeedMode.FROM_PROFILE, profileUser);
    return posts.length;
  }
  /// [FutureIntReturn, NoArgu]
  Future<int> getNumberOfFollowers() async {
    return await userRepository.getNumberOfFollowers(profileUser);
  }
  /// [FutureIntReturn, NoArgu]
  Future<int> getNumberOfFollowings() async {
    return await userRepository.getNumberOfFollowings(profileUser);
  }



  /// [FutureStringrReturn, NoArgu]
  Future<String> pickProfileImage() async {
    /// [postRepositoryの中にpickImageある &&  deviceFileと交換UploadType.GALLERY]
    return (  await postRepository.pickImage(UploadType.GALLERY)  ).path;
  }




  /// [FutureNoReturn, Argu]
  Future<void> updateProfile(String photoUrlUpdated, bool isImageFromFileUpdated, String textNameUpdated, String textBioUpdated) async {
    isProcessing = true;
    notifyListeners();

    await userRepository.updateProfile(
      profileUser,
      photoUrlUpdated,
      isImageFromFileUpdated,
      textNameUpdated,
      textBioUpdated,
    );

    /// [Firestore更新された,,,currentUser更新すればV更新される]
    await userRepository.getCurrentUserById(profileUser.userId);
    profileUser = currentUser;  /// [getterに格納中のもの]

    isProcessing = true;
    notifyListeners();
  }





}