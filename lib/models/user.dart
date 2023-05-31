// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String emailID;
  final String name;
  final String profilePic;
  final String uid;

  const UserModel({
    required this.emailID,
    required this.name,
    required this.profilePic,
    required this.uid,
  });

  UserModel copyWith({
    String? emailID,
    String? name,
    String? profilePic,
    String? uid,
  }) {
    return UserModel(
      emailID: emailID ?? this.emailID,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'emailID': emailID,
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      emailID: map['emailID'] as String,
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      uid: map['uid'] as String,
    );
  }

  @override
  String toString() =>
      'UserModel(emailID: $emailID, name: $name, profilePic: $profilePic, uid: $uid)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.emailID == emailID &&
        other.name == name &&
        other.profilePic == profilePic &&
        other.uid == uid;
  }

  @override
  int get hashCode =>
      emailID.hashCode ^ name.hashCode ^ profilePic.hashCode ^ uid.hashCode;
}
