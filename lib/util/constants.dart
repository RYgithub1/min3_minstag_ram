/// [postPage -> postUploadScreen別に開いてアップロード]
enum UploadType {
  GALLERY,
  CAMERA,
}



/// [caption内容共通化: postからとfeedからで場合分け]
enum PostCaptionOpenMode {
  FROM_POST,
  FROM_FEED,
}



/// [Feed: fromBNB or fromProfileScreen]
enum FeedMode {
  FROM_FEED,    /// [自分とフォロー中のユーザー]
  FROM_PROFILE,    /// [プロフィール画面に表示されるユーザーのみ]
}