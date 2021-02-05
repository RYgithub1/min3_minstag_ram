import 'dart:convert';
import 'package:flutter/material.dart';




class LikeResult {
  final List<Like> likes;
  final bool isLikedToThisPost;
  LikeResult({this.likes, this.isLikedToThisPost});
}



class Like {
  String likeId;
  String postId;   /// [紐づくpost]
  String likeUserId;
  DateTime likeDateTime;   /// [DateTime型-> FIX toMap()/fromMap()]


  /// [Dart Data Class]
  Like({
    @required this.likeId,
    @required this.postId,
    @required this.likeUserId,
    @required this.likeDateTime,
  });



  Like copyWith({
    String likeId,
    String postId,
    String likeUserId,
    DateTime likeDateTime,
  }) {
    return Like(
      likeId: likeId ?? this.likeId,
      postId: postId ?? this.postId,
      likeUserId: likeUserId ?? this.likeUserId,
      likeDateTime: likeDateTime ?? this.likeDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'likeId': likeId,
      'postId': postId,
      'likeUserId': likeUserId,
      // 'likeDateTime': likeDateTime?.millisecondsSinceEpoch,
      'likeDateTime': likeDateTime.toIso8601String()
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Like(
      likeId: map['likeId'],
      postId: map['postId'],
      likeUserId: map['likeUserId'],
      // likeDateTime: DateTime.fromMillisecondsSinceEpoch(map['likeDateTime']),
      likeDateTime: map['likeDateTime'] == null
          ? null
          : DateTime.parse(map['likeDateTime'] as String),   /// [ここのCAST: "String"のみ]
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) => Like.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Like(likeId: $likeId, postId: $postId, likeUserId: $likeUserId, likeDateTime: $likeDateTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Like &&
      o.likeId == likeId &&
      o.postId == postId &&
      o.likeUserId == likeUserId &&
      o.likeDateTime == likeDateTime;
  }

  @override
  int get hashCode {
    return likeId.hashCode ^
      postId.hashCode ^
      likeUserId.hashCode ^
      likeDateTime.hashCode;
  }
}
