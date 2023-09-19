// 投稿がいいねされたことの印
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_report.freezed.dart';
part 'post_report.g.dart';

@freezed
abstract class PostReport with _$PostReport {
  // メールで送信する
  const factory PostReport({
    required String acitiveUid,
    required dynamic createdAt,
    required String others, // その他の報告内容
    required String reportContent, // メインの報告内容
    required String postCreatorUid,
    required String passiveUserName,
    required dynamic postDocRef,
    required String postId,
    required String postReportId,
    required String text,
    required String textLanguageCode,
    required double textNagativeScore,
    required double textPositiveScore,
    required String textSentiment,
  }) = _PostReport;
  factory PostReport.fromJson(Map<String, dynamic> json) =>
      _$PostReportFromJson(json);
}
