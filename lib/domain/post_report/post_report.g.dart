// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostReportImpl _$$PostReportImplFromJson(Map<String, dynamic> json) =>
    _$PostReportImpl(
      acitiveUid: json['acitiveUid'] as String,
      createdAt: json['createdAt'],
      others: json['others'] as String,
      reportContent: json['reportContent'] as String,
      postCreatorUid: json['postCreatorUid'] as String,
      passiveUserName: json['passiveUserName'] as String,
      postDocRef: json['postDocRef'],
      postId: json['postId'] as String,
      postReportId: json['postReportId'] as String,
      text: json['text'] as String,
      textLanguageCode: json['textLanguageCode'] as String,
      textNagativeScore: (json['textNagativeScore'] as num).toDouble(),
      textPositiveScore: (json['textPositiveScore'] as num).toDouble(),
      textSentiment: json['textSentiment'] as String,
    );

Map<String, dynamic> _$$PostReportImplToJson(_$PostReportImpl instance) =>
    <String, dynamic>{
      'acitiveUid': instance.acitiveUid,
      'createdAt': instance.createdAt,
      'others': instance.others,
      'reportContent': instance.reportContent,
      'postCreatorUid': instance.postCreatorUid,
      'passiveUserName': instance.passiveUserName,
      'postDocRef': instance.postDocRef,
      'postId': instance.postId,
      'postReportId': instance.postReportId,
      'text': instance.text,
      'textLanguageCode': instance.textLanguageCode,
      'textNagativeScore': instance.textNagativeScore,
      'textPositiveScore': instance.textPositiveScore,
      'textSentiment': instance.textSentiment,
    };
