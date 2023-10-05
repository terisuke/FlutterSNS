// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_comment_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostCommentReport _$PostCommentReportFromJson(Map<String, dynamic> json) {
  return _PostCommentReport.fromJson(json);
}

/// @nodoc
mixin _$PostCommentReport {
  String get acitiveUid => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get others => throw _privateConstructorUsedError; // その他の報告内容
  String get reportContent => throw _privateConstructorUsedError; // メインの報告内容
  String get postCommentCreatorUid => throw _privateConstructorUsedError;
  String get passiveUserName => throw _privateConstructorUsedError;
  dynamic get postCommentDocRef => throw _privateConstructorUsedError;
  String get postCommentId => throw _privateConstructorUsedError;
  String get postCommentReportId => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  String get commentLanguageCode => throw _privateConstructorUsedError;
  double get commentNagativeScore => throw _privateConstructorUsedError;
  double get commentPositiveScore => throw _privateConstructorUsedError;
  String get commentSentiment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCommentReportCopyWith<PostCommentReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCommentReportCopyWith<$Res> {
  factory $PostCommentReportCopyWith(
          PostCommentReport value, $Res Function(PostCommentReport) then) =
      _$PostCommentReportCopyWithImpl<$Res, PostCommentReport>;
  @useResult
  $Res call(
      {String acitiveUid,
      dynamic createdAt,
      String others,
      String reportContent,
      String postCommentCreatorUid,
      String passiveUserName,
      dynamic postCommentDocRef,
      String postCommentId,
      String postCommentReportId,
      String comment,
      String commentLanguageCode,
      double commentNagativeScore,
      double commentPositiveScore,
      String commentSentiment});
}

/// @nodoc
class _$PostCommentReportCopyWithImpl<$Res, $Val extends PostCommentReport>
    implements $PostCommentReportCopyWith<$Res> {
  _$PostCommentReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? acitiveUid = null,
    Object? createdAt = freezed,
    Object? others = null,
    Object? reportContent = null,
    Object? postCommentCreatorUid = null,
    Object? passiveUserName = null,
    Object? postCommentDocRef = freezed,
    Object? postCommentId = null,
    Object? postCommentReportId = null,
    Object? comment = null,
    Object? commentLanguageCode = null,
    Object? commentNagativeScore = null,
    Object? commentPositiveScore = null,
    Object? commentSentiment = null,
  }) {
    return _then(_value.copyWith(
      acitiveUid: null == acitiveUid
          ? _value.acitiveUid
          : acitiveUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      others: null == others
          ? _value.others
          : others // ignore: cast_nullable_to_non_nullable
              as String,
      reportContent: null == reportContent
          ? _value.reportContent
          : reportContent // ignore: cast_nullable_to_non_nullable
              as String,
      postCommentCreatorUid: null == postCommentCreatorUid
          ? _value.postCommentCreatorUid
          : postCommentCreatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      passiveUserName: null == passiveUserName
          ? _value.passiveUserName
          : passiveUserName // ignore: cast_nullable_to_non_nullable
              as String,
      postCommentDocRef: freezed == postCommentDocRef
          ? _value.postCommentDocRef
          : postCommentDocRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postCommentId: null == postCommentId
          ? _value.postCommentId
          : postCommentId // ignore: cast_nullable_to_non_nullable
              as String,
      postCommentReportId: null == postCommentReportId
          ? _value.postCommentReportId
          : postCommentReportId // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      commentLanguageCode: null == commentLanguageCode
          ? _value.commentLanguageCode
          : commentLanguageCode // ignore: cast_nullable_to_non_nullable
              as String,
      commentNagativeScore: null == commentNagativeScore
          ? _value.commentNagativeScore
          : commentNagativeScore // ignore: cast_nullable_to_non_nullable
              as double,
      commentPositiveScore: null == commentPositiveScore
          ? _value.commentPositiveScore
          : commentPositiveScore // ignore: cast_nullable_to_non_nullable
              as double,
      commentSentiment: null == commentSentiment
          ? _value.commentSentiment
          : commentSentiment // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostCommentReportImplCopyWith<$Res>
    implements $PostCommentReportCopyWith<$Res> {
  factory _$$PostCommentReportImplCopyWith(_$PostCommentReportImpl value,
          $Res Function(_$PostCommentReportImpl) then) =
      __$$PostCommentReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String acitiveUid,
      dynamic createdAt,
      String others,
      String reportContent,
      String postCommentCreatorUid,
      String passiveUserName,
      dynamic postCommentDocRef,
      String postCommentId,
      String postCommentReportId,
      String comment,
      String commentLanguageCode,
      double commentNagativeScore,
      double commentPositiveScore,
      String commentSentiment});
}

/// @nodoc
class __$$PostCommentReportImplCopyWithImpl<$Res>
    extends _$PostCommentReportCopyWithImpl<$Res, _$PostCommentReportImpl>
    implements _$$PostCommentReportImplCopyWith<$Res> {
  __$$PostCommentReportImplCopyWithImpl(_$PostCommentReportImpl _value,
      $Res Function(_$PostCommentReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? acitiveUid = null,
    Object? createdAt = freezed,
    Object? others = null,
    Object? reportContent = null,
    Object? postCommentCreatorUid = null,
    Object? passiveUserName = null,
    Object? postCommentDocRef = freezed,
    Object? postCommentId = null,
    Object? postCommentReportId = null,
    Object? comment = null,
    Object? commentLanguageCode = null,
    Object? commentNagativeScore = null,
    Object? commentPositiveScore = null,
    Object? commentSentiment = null,
  }) {
    return _then(_$PostCommentReportImpl(
      acitiveUid: null == acitiveUid
          ? _value.acitiveUid
          : acitiveUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      others: null == others
          ? _value.others
          : others // ignore: cast_nullable_to_non_nullable
              as String,
      reportContent: null == reportContent
          ? _value.reportContent
          : reportContent // ignore: cast_nullable_to_non_nullable
              as String,
      postCommentCreatorUid: null == postCommentCreatorUid
          ? _value.postCommentCreatorUid
          : postCommentCreatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      passiveUserName: null == passiveUserName
          ? _value.passiveUserName
          : passiveUserName // ignore: cast_nullable_to_non_nullable
              as String,
      postCommentDocRef: freezed == postCommentDocRef
          ? _value.postCommentDocRef
          : postCommentDocRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postCommentId: null == postCommentId
          ? _value.postCommentId
          : postCommentId // ignore: cast_nullable_to_non_nullable
              as String,
      postCommentReportId: null == postCommentReportId
          ? _value.postCommentReportId
          : postCommentReportId // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      commentLanguageCode: null == commentLanguageCode
          ? _value.commentLanguageCode
          : commentLanguageCode // ignore: cast_nullable_to_non_nullable
              as String,
      commentNagativeScore: null == commentNagativeScore
          ? _value.commentNagativeScore
          : commentNagativeScore // ignore: cast_nullable_to_non_nullable
              as double,
      commentPositiveScore: null == commentPositiveScore
          ? _value.commentPositiveScore
          : commentPositiveScore // ignore: cast_nullable_to_non_nullable
              as double,
      commentSentiment: null == commentSentiment
          ? _value.commentSentiment
          : commentSentiment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostCommentReportImpl implements _PostCommentReport {
  const _$PostCommentReportImpl(
      {required this.acitiveUid,
      required this.createdAt,
      required this.others,
      required this.reportContent,
      required this.postCommentCreatorUid,
      required this.passiveUserName,
      required this.postCommentDocRef,
      required this.postCommentId,
      required this.postCommentReportId,
      required this.comment,
      required this.commentLanguageCode,
      required this.commentNagativeScore,
      required this.commentPositiveScore,
      required this.commentSentiment});

  factory _$PostCommentReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostCommentReportImplFromJson(json);

  @override
  final String acitiveUid;
  @override
  final dynamic createdAt;
  @override
  final String others;
// その他の報告内容
  @override
  final String reportContent;
// メインの報告内容
  @override
  final String postCommentCreatorUid;
  @override
  final String passiveUserName;
  @override
  final dynamic postCommentDocRef;
  @override
  final String postCommentId;
  @override
  final String postCommentReportId;
  @override
  final String comment;
  @override
  final String commentLanguageCode;
  @override
  final double commentNagativeScore;
  @override
  final double commentPositiveScore;
  @override
  final String commentSentiment;

  @override
  String toString() {
    return 'PostCommentReport(acitiveUid: $acitiveUid, createdAt: $createdAt, others: $others, reportContent: $reportContent, postCommentCreatorUid: $postCommentCreatorUid, passiveUserName: $passiveUserName, postCommentDocRef: $postCommentDocRef, postCommentId: $postCommentId, postCommentReportId: $postCommentReportId, comment: $comment, commentLanguageCode: $commentLanguageCode, commentNagativeScore: $commentNagativeScore, commentPositiveScore: $commentPositiveScore, commentSentiment: $commentSentiment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostCommentReportImpl &&
            (identical(other.acitiveUid, acitiveUid) ||
                other.acitiveUid == acitiveUid) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.others, others) || other.others == others) &&
            (identical(other.reportContent, reportContent) ||
                other.reportContent == reportContent) &&
            (identical(other.postCommentCreatorUid, postCommentCreatorUid) ||
                other.postCommentCreatorUid == postCommentCreatorUid) &&
            (identical(other.passiveUserName, passiveUserName) ||
                other.passiveUserName == passiveUserName) &&
            const DeepCollectionEquality()
                .equals(other.postCommentDocRef, postCommentDocRef) &&
            (identical(other.postCommentId, postCommentId) ||
                other.postCommentId == postCommentId) &&
            (identical(other.postCommentReportId, postCommentReportId) ||
                other.postCommentReportId == postCommentReportId) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.commentLanguageCode, commentLanguageCode) ||
                other.commentLanguageCode == commentLanguageCode) &&
            (identical(other.commentNagativeScore, commentNagativeScore) ||
                other.commentNagativeScore == commentNagativeScore) &&
            (identical(other.commentPositiveScore, commentPositiveScore) ||
                other.commentPositiveScore == commentPositiveScore) &&
            (identical(other.commentSentiment, commentSentiment) ||
                other.commentSentiment == commentSentiment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      acitiveUid,
      const DeepCollectionEquality().hash(createdAt),
      others,
      reportContent,
      postCommentCreatorUid,
      passiveUserName,
      const DeepCollectionEquality().hash(postCommentDocRef),
      postCommentId,
      postCommentReportId,
      comment,
      commentLanguageCode,
      commentNagativeScore,
      commentPositiveScore,
      commentSentiment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostCommentReportImplCopyWith<_$PostCommentReportImpl> get copyWith =>
      __$$PostCommentReportImplCopyWithImpl<_$PostCommentReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostCommentReportImplToJson(
      this,
    );
  }
}

abstract class _PostCommentReport implements PostCommentReport {
  const factory _PostCommentReport(
      {required final String acitiveUid,
      required final dynamic createdAt,
      required final String others,
      required final String reportContent,
      required final String postCommentCreatorUid,
      required final String passiveUserName,
      required final dynamic postCommentDocRef,
      required final String postCommentId,
      required final String postCommentReportId,
      required final String comment,
      required final String commentLanguageCode,
      required final double commentNagativeScore,
      required final double commentPositiveScore,
      required final String commentSentiment}) = _$PostCommentReportImpl;

  factory _PostCommentReport.fromJson(Map<String, dynamic> json) =
      _$PostCommentReportImpl.fromJson;

  @override
  String get acitiveUid;
  @override
  dynamic get createdAt;
  @override
  String get others;
  @override // その他の報告内容
  String get reportContent;
  @override // メインの報告内容
  String get postCommentCreatorUid;
  @override
  String get passiveUserName;
  @override
  dynamic get postCommentDocRef;
  @override
  String get postCommentId;
  @override
  String get postCommentReportId;
  @override
  String get comment;
  @override
  String get commentLanguageCode;
  @override
  double get commentNagativeScore;
  @override
  double get commentPositiveScore;
  @override
  String get commentSentiment;
  @override
  @JsonKey(ignore: true)
  _$$PostCommentReportImplCopyWith<_$PostCommentReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
