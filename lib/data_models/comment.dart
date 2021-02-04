import 'dart:convert';
import 'package:flutter/material.dart';



class Comment {
  String commentId;
  String postId;   /// [FK: どのpostに紐づくか]
  String commentUserId;
  String comment;
  DateTime commentDateTime;   /// [DateTime型 -> toMap()/fromMap()修正]


  /// [Dart Data Class]
  Comment({
    @required this.commentId,
    @required this.postId,
    @required this.commentUserId,
    @required this.comment,
    @required this.commentDateTime,
  });




  Comment copyWith({
    String commentId,
    String postId,
    String commentUserId,
    String comment,
    DateTime commentDateTime,
  }) {
    return Comment(
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      commentUserId: commentUserId ?? this.commentUserId,
      comment: comment ?? this.comment,
      commentDateTime: commentDateTime ?? this.commentDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'postId': postId,
      'commentUserId': commentUserId,
      'comment': comment,
      // 'commentDateTime': commentDateTime?.millisecondsSinceEpoch,
      'commentDateTime': commentDateTime.toIso8601String(),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Comment(
      commentId: map['commentId'],
      postId: map['postId'],
      commentUserId: map['commentUserId'],
      comment: map['comment'],
      // commentDateTime: DateTime.fromMillisecondsSinceEpoch(map['commentDateTime']),
      commentDateTime: map['commentDateTime'] == null
          ? null
          : DateTime.parse(map['commentDateTime'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(commentId: $commentId, postId: $postId, commentUserId: $commentUserId, comment: $comment, commentDateTime: $commentDateTime)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Comment &&
      o.commentId == commentId &&
      o.postId == postId &&
      o.commentUserId == commentUserId &&
      o.comment == comment &&
      o.commentDateTime == commentDateTime;
  }

  @override
  int get hashCode {
    return commentId.hashCode ^
      postId.hashCode ^
      commentUserId.hashCode ^
      comment.hashCode ^
      commentDateTime.hashCode;
  }
}
