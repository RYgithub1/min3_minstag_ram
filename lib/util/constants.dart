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