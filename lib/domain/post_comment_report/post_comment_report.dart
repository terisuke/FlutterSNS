// 投稿がいいねされたことの印
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_comment_report.freezed.dart';
part 'post_comment_report.g.dart';

@freezed
abstract class PostCommentReport with _$PostCommentReport {
  // メールで送信する
  const factory PostCommentReport({
    required String acitiveUid,
    required dynamic createdAt,
    required String others, // その他の報告内容
    required String reportContent, // メインの報告内容
    required String postCommentCreatorUid,
    required String passiveUserName,
    required dynamic postCommentDocRef,
    required String postCommentId,
    required String postCommentReportId,
    required String comment,
    required String commentLanguageCode,
    required double commentNagativeScore,
    required double commentPositiveScore,
    required String commentSentiment,
  }) = _PostCommentReport;
  factory PostCommentReport.fromJson(Map<String, dynamic> json) =>
      _$PostCommentReportFromJson(json);
}
