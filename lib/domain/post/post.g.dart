// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      createdAt: json['createdAt'],
      hashTags:
          (json['hashTags'] as List<dynamic>).map((e) => e as String).toList(),
      imageURL: json['imageURL'] as String,
      likeCount: json['likeCount'] as int,
      text: json['text'] as String,
      textLanguageCode: json['textLanguageCode'] as String,
      textNagativeScore: (json['textNagativeScore'] as num).toDouble(),
      textPositiveScore: (json['textPositiveScore'] as num).toDouble(),
      textSentiment: json['textSentiment'] as String,
      postCommentCount: json['postCommentCount'] as int,
      postId: json['postId'] as String,
      reportCount: json['reportCount'] as int,
      muteCount: json['muteCount'] as int,
      uid: json['uid'] as String,
      userName: json['userName'] as String,
      userNameLanguageCode: json['userNameLanguageCode'] as String,
      userNameNagativeScore: (json['userNameNagativeScore'] as num).toDouble(),
      userNamePositiveScore: (json['userNamePositiveScore'] as num).toDouble(),
      userNameSentiment: json['userNameSentiment'] as String,
      userImageURL: json['userImageURL'] as String,
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'hashTags': instance.hashTags,
      'imageURL': instance.imageURL,
      'likeCount': instance.likeCount,
      'text': instance.text,
      'textLanguageCode': instance.textLanguageCode,
      'textNagativeScore': instance.textNagativeScore,
      'textPositiveScore': instance.textPositiveScore,
      'textSentiment': instance.textSentiment,
      'postCommentCount': instance.postCommentCount,
      'postId': instance.postId,
      'reportCount': instance.reportCount,
      'muteCount': instance.muteCount,
      'uid': instance.uid,
      'userName': instance.userName,
      'userNameLanguageCode': instance.userNameLanguageCode,
      'userNameNagativeScore': instance.userNameNagativeScore,
      'userNamePositiveScore': instance.userNamePositiveScore,
      'userNameSentiment': instance.userNameSentiment,
      'userImageURL': instance.userImageURL,
      'updatedAt': instance.updatedAt,
    };
