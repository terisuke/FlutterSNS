// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirestoreUserImpl _$$FirestoreUserImplFromJson(Map<String, dynamic> json) =>
    _$FirestoreUserImpl(
      createdAt: json['createdAt'],
      followerCount: json['followerCount'] as int,
      followingCount: json['followingCount'] as int,
      isAdmin: json['isAdmin'] as bool,
      muteCount: json['muteCount'] as int,
      searchToken: json['searchToken'] as Map<String, dynamic>,
      postCount: json['postCount'] as int,
      userName: json['userName'] as String,
      userNameLanguageCode: json['userNameLanguageCode'] as String,
      userNameNagativeScore: (json['userNameNagativeScore'] as num).toDouble(),
      userNamePositiveScore: (json['userNamePositiveScore'] as num).toDouble(),
      userNameSentiment: json['userNameSentiment'] as String,
      userImageURL: json['userImageURL'] as String,
      uid: json['uid'] as String,
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$FirestoreUserImplToJson(_$FirestoreUserImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'followerCount': instance.followerCount,
      'followingCount': instance.followingCount,
      'isAdmin': instance.isAdmin,
      'muteCount': instance.muteCount,
      'searchToken': instance.searchToken,
      'postCount': instance.postCount,
      'userName': instance.userName,
      'userNameLanguageCode': instance.userNameLanguageCode,
      'userNameNagativeScore': instance.userNameNagativeScore,
      'userNamePositiveScore': instance.userNamePositiveScore,
      'userNameSentiment': instance.userNameSentiment,
      'userImageURL': instance.userImageURL,
      'uid': instance.uid,
      'updatedAt': instance.updatedAt,
    };
