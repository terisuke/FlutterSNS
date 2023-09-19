// 投稿がいいねされたことの印
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_comment_reply_report.freezed.dart';
part 'post_comment_reply_report.g.dart';

@freezed
abstract class PostCommentReplyReport with _$PostCommentReplyReport {
  // メールで送信する
  const factory PostCommentReplyReport({
    required String acitiveUid,
    required dynamic createdAt,
    required String others, // その他の報告内容
    required String reportContent, // メインの報告内容
    required String postCommentReplyCreatorUid,
    required String passiveUserName,
    required dynamic postCommentReplyDocRef,
    required String postCommentReplyId,
    required String postCommentReplyReportId,
    required String reply,
    required String replyLanguageCode,
    required double replyNagativeScore,
    required double replyPositiveScore,
    required String replySentiment,
  }) = _PostCommentReplyReport;
  factory PostCommentReplyReport.fromJson(Map<String, dynamic> json) =>
      _$PostCommentReplyReportFromJson(json);
}
