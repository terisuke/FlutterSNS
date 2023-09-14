import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required dynamic createdAt,
    required String comment,
    required int likeCount,
    required String postCommentId,
    required int postCommentReplyCount,
    required String userName,
    required String uid,
    required String userImageURL,
  }) = _Comment;
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
