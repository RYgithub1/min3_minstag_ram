import 'dart:convert';
import 'package:flutter/material.dart';



class User {
  final String userId;
  final String displayName;   // Firebaseに登録したUser情報に紐づくユーサー名(googleAccountUserName)
  final String inAppUserName;   // アプリ内で編集可能なユーザー名(nickname)
  final String photoUrl;
  final String email;
  final String bio;   // プロフィール文


  /// [====== Dart Data Class ======]
  const User({
    @required this.userId,
    @required this.displayName,
    @required this.inAppUserName,
    @required this.photoUrl,
    @required this.email,
    @required this.bio,
  });



  User copyWith({
    String userId,
    String displayName,
    String inAppUserName,
    String photoUrl,
    String email,
    String bio,
  }) {
    return User(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      inAppUserName: inAppUserName ?? this.inAppUserName,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {  
    return {
      'userId': userId,
      'displayName': displayName,
      'inAppUserName': inAppUserName,
      'photoUrl': photoUrl,
      'email': email,
      'bio': bio,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      userId: map['userId'],
      displayName: map['displayName'],
      inAppUserName: map['inAppUserName'],
      photoUrl: map['photoUrl'],
      email: map['email'],
      bio: map['bio'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(userId: $userId, displayName: $displayName, inAppUserName: $inAppUserName, photoUrl: $photoUrl, email: $email, bio: $bio)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.userId == userId &&
      o.displayName == displayName &&
      o.inAppUserName == inAppUserName &&
      o.photoUrl == photoUrl &&
      o.email == email &&
      o.bio == bio;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      displayName.hashCode ^
      inAppUserName.hashCode ^
      photoUrl.hashCode ^
      email.hashCode ^
      bio.hashCode;
  }
}

