// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreUser _$$_FirestoreUserFromJson(Map<String, dynamic> json) =>
    _$_FirestoreUser(
      createdAt: json['createdAt'],
      followerCount: json['followerCount'] as int,
      followingCount: json['followingCount'] as int,
      isAdmin: json['isAdmin'] as bool,
      userName: json['userName'] as String,
      userImageURL: json['userImageURL'] as String,
      uid: json['uid'] as String,
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$_FirestoreUserToJson(_$_FirestoreUser instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'followerCount': instance.followerCount,
      'followingCount': instance.followingCount,
      'isAdmin': instance.isAdmin,
      'userName': instance.userName,
      'userImageURL': instance.userImageURL,
      'uid': instance.uid,
      'updatedAt': instance.updatedAt,
    };
