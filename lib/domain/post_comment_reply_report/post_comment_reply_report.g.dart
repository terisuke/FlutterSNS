// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_reply_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostCommentReplyReportImpl _$$PostCommentReplyReportImplFromJson(
        Map<String, dynamic> json) =>
    _$PostCommentReplyReportImpl(
      acitiveUid: json['acitiveUid'] as String,
      createdAt: json['createdAt'],
      others: json['others'] as String,
      reportContent: json['reportContent'] as String,
      postCommentReplyCreatorUid: json['postCommentReplyCreatorUid'] as String,
      passiveUserName: json['passiveUserName'] as String,
      postCommentReplyDocRef: json['postCommentReplyDocRef'],
      postCommentReplyId: json['postCommentReplyId'] as String,
      postCommentReplyReportId: json['postCommentReplyReportId'] as String,
      reply: json['reply'] as String,
      replyLanguageCode: json['replyLanguageCode'] as String,
      replyNagativeScore: (json['replyNagativeScore'] as num).toDouble(),
      replyPositiveScore: (json['replyPositiveScore'] as num).toDouble(),
      replySentiment: json['replySentiment'] as String,
    );

Map<String, dynamic> _$$PostCommentReplyReportImplToJson(
        _$PostCommentReplyReportImpl instance) =>
    <String, dynamic>{
      'acitiveUid': instance.acitiveUid,
      'createdAt': instance.createdAt,
      'others': instance.others,
      'reportContent': instance.reportContent,
      'postCommentReplyCreatorUid': instance.postCommentReplyCreatorUid,
      'passiveUserName': instance.passiveUserName,
      'postCommentReplyDocRef': instance.postCommentReplyDocRef,
      'postCommentReplyId': instance.postCommentReplyId,
      'postCommentReplyReportId': instance.postCommentReplyReportId,
      'reply': instance.reply,
      'replyLanguageCode': instance.replyLanguageCode,
      'replyNagativeScore': instance.replyNagativeScore,
      'replyPositiveScore': instance.replyPositiveScore,
      'replySentiment': instance.replySentiment,
    };
