// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Reply _$$_ReplyFromJson(Map<String, dynamic> json) => _$_Reply(
      createdAt: json['createdAt'],
      reply: json['reply'] as String,
      likeCount: json['likeCount'] as int,
      muteCount: json['muteCount'] as int,
      postRef: json['postRef'],
      postCommentRef: json['postCommentRef'],
      postCommentReplyId: json['postCommentReplyId'] as String,
      userName: json['userName'] as String,
      uid: json['uid'] as String,
      userImageURL: json['userImageURL'] as String,
      updatedAt: json['updatedAt'],
    );

Map<String, dynamic> _$$_ReplyToJson(_$_Reply instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'reply': instance.reply,
      'likeCount': instance.likeCount,
      'muteCount': instance.muteCount,
      'postRef': instance.postRef,
      'postCommentRef': instance.postCommentRef,
      'postCommentReplyId': instance.postCommentReplyId,
      'userName': instance.userName,
      'uid': instance.uid,
      'userImageURL': instance.userImageURL,
      'updatedAt': instance.updatedAt,
    };
