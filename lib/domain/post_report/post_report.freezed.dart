// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostReport _$PostReportFromJson(Map<String, dynamic> json) {
  return _PostReport.fromJson(json);
}

/// @nodoc
mixin _$PostReport {
  String get acitiveUid => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get others => throw _privateConstructorUsedError; // その他の報告内容
  String get reportContent => throw _privateConstructorUsedError; // メインの報告内容
  String get postCreatorUid => throw _privateConstructorUsedError;
  String get passiveUserName => throw _privateConstructorUsedError;
  dynamic get postDocRef => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  String get postReportId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get textLanguageCode => throw _privateConstructorUsedError;
  double get textNagativeScore => throw _privateConstructorUsedError;
  double get textPositiveScore => throw _privateConstructorUsedError;
  String get textSentiment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostReportCopyWith<PostReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostReportCopyWith<$Res> {
  factory $PostReportCopyWith(
          PostReport value, $Res Function(PostReport) then) =
      _$PostReportCopyWithImpl<$Res, PostReport>;
  @useResult
  $Res call(
      {String acitiveUid,
      dynamic createdAt,
      String others,
      String reportContent,
      String postCreatorUid,
      String passiveUserName,
      dynamic postDocRef,
      String postId,
      String postReportId,
      String text,
      String textLanguageCode,
      double textNagativeScore,
      double textPositiveScore,
      String textSentiment});
}

/// @nodoc
class _$PostReportCopyWithImpl<$Res, $Val extends PostReport>
    implements $PostReportCopyWith<$Res> {
  _$PostReportCopyWithImpl(this._value, this._then);

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
    Object? postCreatorUid = null,
    Object? passiveUserName = null,
    Object? postDocRef = freezed,
    Object? postId = null,
    Object? postReportId = null,
    Object? text = null,
    Object? textLanguageCode = null,
    Object? textNagativeScore = null,
    Object? textPositiveScore = null,
    Object? textSentiment = null,
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
      postCreatorUid: null == postCreatorUid
          ? _value.postCreatorUid
          : postCreatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      passiveUserName: null == passiveUserName
          ? _value.passiveUserName
          : passiveUserName // ignore: cast_nullable_to_non_nullable
              as String,
      postDocRef: freezed == postDocRef
          ? _value.postDocRef
          : postDocRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      postReportId: null == postReportId
          ? _value.postReportId
          : postReportId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      textLanguageCode: null == textLanguageCode
          ? _value.textLanguageCode
          : textLanguageCode // ignore: cast_nullable_to_non_nullable
              as String,
      textNagativeScore: null == textNagativeScore
          ? _value.textNagativeScore
          : textNagativeScore // ignore: cast_nullable_to_non_nullable
              as double,
      textPositiveScore: null == textPositiveScore
          ? _value.textPositiveScore
          : textPositiveScore // ignore: cast_nullable_to_non_nullable
              as double,
      textSentiment: null == textSentiment
          ? _value.textSentiment
          : textSentiment // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostReportImplCopyWith<$Res>
    implements $PostReportCopyWith<$Res> {
  factory _$$PostReportImplCopyWith(
          _$PostReportImpl value, $Res Function(_$PostReportImpl) then) =
      __$$PostReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String acitiveUid,
      dynamic createdAt,
      String others,
      String reportContent,
      String postCreatorUid,
      String passiveUserName,
      dynamic postDocRef,
      String postId,
      String postReportId,
      String text,
      String textLanguageCode,
      double textNagativeScore,
      double textPositiveScore,
      String textSentiment});
}

/// @nodoc
class __$$PostReportImplCopyWithImpl<$Res>
    extends _$PostReportCopyWithImpl<$Res, _$PostReportImpl>
    implements _$$PostReportImplCopyWith<$Res> {
  __$$PostReportImplCopyWithImpl(
      _$PostReportImpl _value, $Res Function(_$PostReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? acitiveUid = null,
    Object? createdAt = freezed,
    Object? others = null,
    Object? reportContent = null,
    Object? postCreatorUid = null,
    Object? passiveUserName = null,
    Object? postDocRef = freezed,
    Object? postId = null,
    Object? postReportId = null,
    Object? text = null,
    Object? textLanguageCode = null,
    Object? textNagativeScore = null,
    Object? textPositiveScore = null,
    Object? textSentiment = null,
  }) {
    return _then(_$PostReportImpl(
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
      postCreatorUid: null == postCreatorUid
          ? _value.postCreatorUid
          : postCreatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      passiveUserName: null == passiveUserName
          ? _value.passiveUserName
          : passiveUserName // ignore: cast_nullable_to_non_nullable
              as String,
      postDocRef: freezed == postDocRef
          ? _value.postDocRef
          : postDocRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      postReportId: null == postReportId
          ? _value.postReportId
          : postReportId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      textLanguageCode: null == textLanguageCode
          ? _value.textLanguageCode
          : textLanguageCode // ignore: cast_nullable_to_non_nullable
              as String,
      textNagativeScore: null == textNagativeScore
          ? _value.textNagativeScore
          : textNagativeScore // ignore: cast_nullable_to_non_nullable
              as double,
      textPositiveScore: null == textPositiveScore
          ? _value.textPositiveScore
          : textPositiveScore // ignore: cast_nullable_to_non_nullable
              as double,
      textSentiment: null == textSentiment
          ? _value.textSentiment
          : textSentiment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostReportImpl implements _PostReport {
  const _$PostReportImpl(
      {required this.acitiveUid,
      required this.createdAt,
      required this.others,
      required this.reportContent,
      required this.postCreatorUid,
      required this.passiveUserName,
      required this.postDocRef,
      required this.postId,
      required this.postReportId,
      required this.text,
      required this.textLanguageCode,
      required this.textNagativeScore,
      required this.textPositiveScore,
      required this.textSentiment});

  factory _$PostReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostReportImplFromJson(json);

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
  final String postCreatorUid;
  @override
  final String passiveUserName;
  @override
  final dynamic postDocRef;
  @override
  final String postId;
  @override
  final String postReportId;
  @override
  final String text;
  @override
  final String textLanguageCode;
  @override
  final double textNagativeScore;
  @override
  final double textPositiveScore;
  @override
  final String textSentiment;

  @override
  String toString() {
    return 'PostReport(acitiveUid: $acitiveUid, createdAt: $createdAt, others: $others, reportContent: $reportContent, postCreatorUid: $postCreatorUid, passiveUserName: $passiveUserName, postDocRef: $postDocRef, postId: $postId, postReportId: $postReportId, text: $text, textLanguageCode: $textLanguageCode, textNagativeScore: $textNagativeScore, textPositiveScore: $textPositiveScore, textSentiment: $textSentiment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostReportImpl &&
            (identical(other.acitiveUid, acitiveUid) ||
                other.acitiveUid == acitiveUid) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.others, others) || other.others == others) &&
            (identical(other.reportContent, reportContent) ||
                other.reportContent == reportContent) &&
            (identical(other.postCreatorUid, postCreatorUid) ||
                other.postCreatorUid == postCreatorUid) &&
            (identical(other.passiveUserName, passiveUserName) ||
                other.passiveUserName == passiveUserName) &&
            const DeepCollectionEquality()
                .equals(other.postDocRef, postDocRef) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.postReportId, postReportId) ||
                other.postReportId == postReportId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.textLanguageCode, textLanguageCode) ||
                other.textLanguageCode == textLanguageCode) &&
            (identical(other.textNagativeScore, textNagativeScore) ||
                other.textNagativeScore == textNagativeScore) &&
            (identical(other.textPositiveScore, textPositiveScore) ||
                other.textPositiveScore == textPositiveScore) &&
            (identical(other.textSentiment, textSentiment) ||
                other.textSentiment == textSentiment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      acitiveUid,
      const DeepCollectionEquality().hash(createdAt),
      others,
      reportContent,
      postCreatorUid,
      passiveUserName,
      const DeepCollectionEquality().hash(postDocRef),
      postId,
      postReportId,
      text,
      textLanguageCode,
      textNagativeScore,
      textPositiveScore,
      textSentiment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostReportImplCopyWith<_$PostReportImpl> get copyWith =>
      __$$PostReportImplCopyWithImpl<_$PostReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostReportImplToJson(
      this,
    );
  }
}

abstract class _PostReport implements PostReport {
  const factory _PostReport(
      {required final String acitiveUid,
      required final dynamic createdAt,
      required final String others,
      required final String reportContent,
      required final String postCreatorUid,
      required final String passiveUserName,
      required final dynamic postDocRef,
      required final String postId,
      required final String postReportId,
      required final String text,
      required final String textLanguageCode,
      required final double textNagativeScore,
      required final double textPositiveScore,
      required final String textSentiment}) = _$PostReportImpl;

  factory _PostReport.fromJson(Map<String, dynamic> json) =
      _$PostReportImpl.fromJson;

  @override
  String get acitiveUid;
  @override
  dynamic get createdAt;
  @override
  String get others;
  @override // その他の報告内容
  String get reportContent;
  @override // メインの報告内容
  String get postCreatorUid;
  @override
  String get passiveUserName;
  @override
  dynamic get postDocRef;
  @override
  String get postId;
  @override
  String get postReportId;
  @override
  String get text;
  @override
  String get textLanguageCode;
  @override
  double get textNagativeScore;
  @override
  double get textPositiveScore;
  @override
  String get textSentiment;
  @override
  @JsonKey(ignore: true)
  _$$PostReportImplCopyWith<_$PostReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
