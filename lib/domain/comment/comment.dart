import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required dynamic createdAt,
    required String comment,
    required String commentLanguageCode,
    required double commentNagativeScore,
    required double commentPositiveScore,
    required String commentSentiment,
    required int likeCount,
    required dynamic postRef,
    required String postCommentId,
    required int postCommentReplyCount,
    required int reportCount,
    required int muteCount,
    required String userName,
    required String userNameLanguageCode,
    required double userNameNagativeScore,
    required double userNamePositiveScore,
    required String userNameSentiment,
    required String uid,
    required String userImageURL,
    required dynamic updatedAt,
  }) = _Comment;
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
