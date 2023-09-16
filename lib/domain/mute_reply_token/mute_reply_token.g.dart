// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mute_reply_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MuteReplyToken _$$_MuteReplyTokenFromJson(Map<String, dynamic> json) =>
    _$_MuteReplyToken(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postCommentReplyId: json['postCommentReplyId'] as String,
      postCommentReplyRef: json['postCommentReplyRef'],
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$_MuteReplyTokenToJson(_$_MuteReplyToken instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postCommentReplyId': instance.postCommentReplyId,
      'postCommentReplyRef': instance.postCommentReplyRef,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
