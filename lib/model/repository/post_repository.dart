import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:min3_minstag_ram/data_models/comment.dart';
import 'package:min3_minstag_ram/data_models/location.dart';
import 'package:min3_minstag_ram/data_models/post.dart';
import 'package:min3_minstag_ram/data_models/user.dart';
import 'package:min3_minstag_ram/model/database/database_manager.dart';
import 'package:min3_minstag_ram/model/location/location_manager.dart';
import 'package:min3_minstag_ram/util/constants.dart';
import 'package:uuid/uuid.dart';




class PostRepository {
  final DatabaseManager dbManager;
  final LocationManager locationManager;
  PostRepository({this.dbManager, this.locationManager});



  Future<File> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();
    if (uploadType == UploadType.GALLERY) {
      // return await imagePicker.getImage(source: ImageSource.gallery);
      /// [A value of type 'PickedFile' can't be returned from method 'pickImage' because it has a return type of 'Future<File>'.]
      final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
      return File(pickedImage.path);
    } else {
      final pickedImage = await imagePicker.getImage(source: ImageSource.camera);
      return File(pickedImage.path);
    }
  }


  Future<Location> getCurrentLocation() async {
    return await locationManager.getCurrentLocation();
  }


  Future<Location> updateLocation(double latitude, double longitude) async {
    return await locationManager.updateLocation(latitude, longitude);
  }


  /// [postするだけなので<void>に修正]
  Future<void> post(User currentUser, File imageFile, String caption, Location location, String locationString) async {
    /// Firestore/Storage: 一意のID: UUID
    final storageId = Uuid().v1();
    final imageUrl = await dbManager.uploadImageToStorage(imageFile, storageId);
    print("comm700: PostRepository: storageImageUrl: $imageUrl");
    /// [post: Firestoreに登録したいもの]
    final post = Post(
      postId: Uuid().v1(),
      userId: currentUser.userId,
      imageUrl: imageUrl,
      imageStoragePath: storageId,
      caption: caption,
      locationString: locationString,
      latitude: location.latitude,
      longitude: location.longitude,
      postDateTime: DateTime.now(),
    );
    print("comm700: PostRepository: post: $post");
    await dbManager.insertPost(post);
  }



  // Future<Post> getPosts(FeedMode feedMode) async {
  /// [VM: List<Post> posts: Match Type]
  Future<List<Post>> getPosts(FeedMode feedMode, User feedUser) async {
    /// [feed画面への遷移2パターン]
    if (feedMode == FeedMode.FROM_FEED) {
      /// [R: 自分がフォローしているユーザーの投稿を取得]
      return dbManager.getPostsMineAndFollowings(feedUser.userId);
    } else {   /// [feedMode == FeedMode.FROM_PROFILE]
      /// [R: プロフィール画面に表示されているユーザーの投稿を取得]
      // return dbManager.getPostsByuser(feedUser.userId);
      return null;
    }
  }



  /// [post->feed: Update: R:  Updateなので返り値なし]
  Future<void> updatePost(Post updatePost) async {
    return await dbManager.updatePost(updatePost);
  }



  Future<void> postComment(Post post, User commentUser, String commentString) async {
    /// [必要なComment...DartDataClassに代入して丸ごと渡して、Firestore保存]
    final comment = Comment(
      commentId: Uuid().v1(),   /// [任意16桁1意]
      postId: post.postId,
      commentUserId: commentUser.userId,
      comment: commentString,
      commentDateTime: DateTime.now(),
    );

    await dbManager.postComment(comment);
  }



  /// VM: List<Comment> comments = [];
  /// [取得データをR->VM: Listに格納 => 戻り値List<Comment>]
  Future<List<Comment>> getComment(String postId) async {
    return dbManager.getComment(postId);
  }



  Future<void> deleteComment(String deleteCommentId) async {
    await dbManager.deleteComent(deleteCommentId);
  }



}