// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_reply_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LikeReplyToken _$$_LikeReplyTokenFromJson(Map<String, dynamic> json) =>
    _$_LikeReplyToken(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      passiveUid: json['passiveUid'] as String,
      postCommentReplyRef: json['postCommentReplyRef'],
      postCommentReplyId: json['postCommentReplyId'] as String,
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$_LikeReplyTokenToJson(_$_LikeReplyToken instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'passiveUid': instance.passiveUid,
      'postCommentReplyRef': instance.postCommentReplyRef,
      'postCommentReplyId': instance.postCommentReplyId,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
