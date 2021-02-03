import 'dart:convert';
import 'package:flutter/material.dart';



/// [postデータ格納用クラス]
class Post {
  String postId;
  String userId;
  String imageUrl;
  String imageStoragePath;
  String caption;
  String locationString;
  double latitude;
  double longitude;
  DateTime postDataTime;



  /// [Dart Data Class]
  Post({
    @required this.postId,
    @required this.userId,
    @required this.imageUrl,
    @required this.imageStoragePath,
    @required this.caption,
    @required this.locationString,
    @required this.latitude,
    @required this.longitude,
    @required this.postDataTime,
  });




  Post copyWith({
    String postId,
    String userId,
    String imageUrl,
    String imageStoragePath,
    String caption,
    String locationString,
    double latitude,
    double longitude,
    DateTime postDataTime,
  }) {
    return Post(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      imageStoragePath: imageStoragePath ?? this.imageStoragePath,
      caption: caption ?? this.caption,
      locationString: locationString ?? this.locationString,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      postDataTime: postDataTime ?? this.postDataTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'imageUrl': imageUrl,
      'imageStoragePath': imageStoragePath,
      'caption': caption,
      'locationString': locationString,
      'latitude': latitude,
      'longitude': longitude,
      // 'postDataTime': postDataTime?.millisecondsSinceEpoch,
      /// [Type違いエラー(parseする): DateTimeType <-> StringType]
      'postDataTime': postDataTime.toIso8601String(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Post(
      postId: map['postId'],
      userId: map['userId'],
      imageUrl: map['imageUrl'],
      imageStoragePath: map['imageStoragePath'],
      caption: map['caption'],
      locationString: map['locationString'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      // postDataTime: DateTime.fromMillisecondsSinceEpoch(map['postDataTime']),
      /// [Type違いエラー(parseする): DateTimeType <-> StringType]
      postDataTime: map['postDataTime'] == null
          ? null
          : DateTime.parse(map['postDataTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(postId: $postId, userId: $userId, imageUrl: $imageUrl, imageStoragePath: $imageStoragePath, caption: $caption, locationString: $locationString, latitude: $latitude, longitude: $longitude, postDataTime: $postDataTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Post &&
      o.postId == postId &&
      o.userId == userId &&
      o.imageUrl == imageUrl &&
      o.imageStoragePath == imageStoragePath &&
      o.caption == caption &&
      o.locationString == locationString &&
      o.latitude == latitude &&
      o.longitude == longitude &&
      o.postDataTime == postDataTime;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
      userId.hashCode ^
      imageUrl.hashCode ^
      imageStoragePath.hashCode ^
      caption.hashCode ^
      locationString.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      postDataTime.hashCode;
  }
}
