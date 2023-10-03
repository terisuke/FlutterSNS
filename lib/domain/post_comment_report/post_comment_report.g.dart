// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostCommentReportImpl _$$PostCommentReportImplFromJson(
        Map<String, dynamic> json) =>
    _$PostCommentReportImpl(
      acitiveUid: json['acitiveUid'] as String,
      createdAt: json['createdAt'],
      others: json['others'] as String,
      reportContent: json['reportContent'] as String,
      postCommentCreatorUid: json['postCommentCreatorUid'] as String,
      passiveUserName: json['passiveUserName'] as String,
      postCommentDocRef: json['postCommentDocRef'],
      postCommentId: json['postCommentId'] as String,
      postCommentReportId: json['postCommentReportId'] as String,
      comment: json['comment'] as String,
      commentLanguageCode: json['commentLanguageCode'] as String,
      commentNagativeScore: (json['commentNagativeScore'] as num).toDouble(),
      commentPositiveScore: (json['commentPositiveScore'] as num).toDouble(),
      commentSentiment: json['commentSentiment'] as String,
    );

Map<String, dynamic> _$$PostCommentReportImplToJson(
        _$PostCommentReportImpl instance) =>
    <String, dynamic>{
      'acitiveUid': instance.acitiveUid,
      'createdAt': instance.createdAt,
      'others': instance.others,
      'reportContent': instance.reportContent,
      'postCommentCreatorUid': instance.postCommentCreatorUid,
      'passiveUserName': instance.passiveUserName,
      'postCommentDocRef': instance.postCommentDocRef,
      'postCommentId': instance.postCommentId,
      'postCommentReportId': instance.postCommentReportId,
      'comment': instance.comment,
      'commentLanguageCode': instance.commentLanguageCode,
      'commentNagativeScore': instance.commentNagativeScore,
      'commentPositiveScore': instance.commentPositiveScore,
      'commentSentiment': instance.commentSentiment,
    };
