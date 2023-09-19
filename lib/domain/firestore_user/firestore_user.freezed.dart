// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestoreUser _$FirestoreUserFromJson(Map<String, dynamic> json) {
  return _FirestoreUser.fromJson(json);
}

/// @nodoc
mixin _$FirestoreUser {
  dynamic get createdAt => throw _privateConstructorUsedError;
  int get followerCount => throw _privateConstructorUsedError;
  int get followingCount => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  int get muteCount => throw _privateConstructorUsedError;
  Map<String, dynamic> get searchToken => throw _privateConstructorUsedError;
  int get postCount => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userNameLanguageCode => throw _privateConstructorUsedError;
  double get userNameNagativeScore => throw _privateConstructorUsedError;
  double get userNamePositiveScore => throw _privateConstructorUsedError;
  String get userNameSentiment => throw _privateConstructorUsedError;
  String get userImageURL => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  dynamic get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreUserCopyWith<FirestoreUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreUserCopyWith<$Res> {
  factory $FirestoreUserCopyWith(
          FirestoreUser value, $Res Function(FirestoreUser) then) =
      _$FirestoreUserCopyWithImpl<$Res, FirestoreUser>;
  @useResult
  $Res call(
      {dynamic createdAt,
      int followerCount,
      int followingCount,
      bool isAdmin,
      int muteCount,
      Map<String, dynamic> searchToken,
      int postCount,
      String userName,
      String userNameLanguageCode,
      double userNameNagativeScore,
      double userNamePositiveScore,
      String userNameSentiment,
      String userImageURL,
      String uid,
      dynamic updatedAt});
}

/// @nodoc
class _$FirestoreUserCopyWithImpl<$Res, $Val extends FirestoreUser>
    implements $FirestoreUserCopyWith<$Res> {
  _$FirestoreUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? followerCount = null,
    Object? followingCount = null,
    Object? isAdmin = null,
    Object? muteCount = null,
    Object? searchToken = null,
    Object? postCount = null,
    Object? userName = null,
    Object? userNameLanguageCode = null,
    Object? userNameNagativeScore = null,
    Object? userNamePositiveScore = null,
    Object? userNameSentiment = null,
    Object? userImageURL = null,
    Object? uid = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      followerCount: null == followerCount
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      muteCount: null == muteCount
          ? _value.muteCount
          : muteCount // ignore: cast_nullable_to_non_nullable
              as int,
      searchToken: null == searchToken
          ? _value.searchToken
          : searchToken // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      postCount: null == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userNameLanguageCode: null == userNameLanguageCode
          ? _value.userNameLanguageCode
          : userNameLanguageCode // ignore: cast_nullable_to_non_nullable
              as String,
      userNameNagativeScore: null == userNameNagativeScore
          ? _value.userNameNagativeScore
          : userNameNagativeScore // ignore: cast_nullable_to_non_nullable
              as double,
      userNamePositiveScore: null == userNamePositiveScore
          ? _value.userNamePositiveScore
          : userNamePositiveScore // ignore: cast_nullable_to_non_nullable
              as double,
      userNameSentiment: null == userNameSentiment
          ? _value.userNameSentiment
          : userNameSentiment // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FirestoreUserCopyWith<$Res>
    implements $FirestoreUserCopyWith<$Res> {
  factory _$$_FirestoreUserCopyWith(
          _$_FirestoreUser value, $Res Function(_$_FirestoreUser) then) =
      __$$_FirestoreUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic createdAt,
      int followerCount,
      int followingCount,
      bool isAdmin,
      int muteCount,
      Map<String, dynamic> searchToken,
      int postCount,
      String userName,
      String userNameLanguageCode,
      double userNameNagativeScore,
      double userNamePositiveScore,
      String userNameSentiment,
      String userImageURL,
      String uid,
      dynamic updatedAt});
}

/// @nodoc
class __$$_FirestoreUserCopyWithImpl<$Res>
    extends _$FirestoreUserCopyWithImpl<$Res, _$_FirestoreUser>
    implements _$$_FirestoreUserCopyWith<$Res> {
  __$$_FirestoreUserCopyWithImpl(
      _$_FirestoreUser _value, $Res Function(_$_FirestoreUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? followerCount = null,
    Object? followingCount = null,
    Object? isAdmin = null,
    Object? muteCount = null,
    Object? searchToken = null,
    Object? postCount = null,
    Object? userName = null,
    Object? userNameLanguageCode = null,
    Object? userNameNagativeScore = null,
    Object? userNamePositiveScore = null,
    Object? userNameSentiment = null,
    Object? userImageURL = null,
    Object? uid = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_FirestoreUser(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      followerCount: null == followerCount
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      muteCount: null == muteCount
          ? _value.muteCount
          : muteCount // ignore: cast_nullable_to_non_nullable
              as int,
      searchToken: null == searchToken
          ? _value._searchToken
          : searchToken // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      postCount: null == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userNameLanguageCode: null == userNameLanguageCode
          ? _value.userNameLanguageCode
          : userNameLanguageCode // ignore: cast_nullable_to_non_nullable
              as String,
      userNameNagativeScore: null == userNameNagativeScore
          ? _value.userNameNagativeScore
          : userNameNagativeScore // ignore: cast_nullable_to_non_nullable
              as double,
      userNamePositiveScore: null == userNamePositiveScore
          ? _value.userNamePositiveScore
          : userNamePositiveScore // ignore: cast_nullable_to_non_nullable
              as double,
      userNameSentiment: null == userNameSentiment
          ? _value.userNameSentiment
          : userNameSentiment // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FirestoreUser implements _FirestoreUser {
  const _$_FirestoreUser(
      {required this.createdAt,
      required this.followerCount,
      required this.followingCount,
      required this.isAdmin,
      required this.muteCount,
      required final Map<String, dynamic> searchToken,
      required this.postCount,
      required this.userName,
      required this.userNameLanguageCode,
      required this.userNameNagativeScore,
      required this.userNamePositiveScore,
      required this.userNameSentiment,
      required this.userImageURL,
      required this.uid,
      required this.updatedAt})
      : _searchToken = searchToken;

  factory _$_FirestoreUser.fromJson(Map<String, dynamic> json) =>
      _$$_FirestoreUserFromJson(json);

  @override
  final dynamic createdAt;
  @override
  final int followerCount;
  @override
  final int followingCount;
  @override
  final bool isAdmin;
  @override
  final int muteCount;
  final Map<String, dynamic> _searchToken;
  @override
  Map<String, dynamic> get searchToken {
    if (_searchToken is EqualUnmodifiableMapView) return _searchToken;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_searchToken);
  }

  @override
  final int postCount;
  @override
  final String userName;
  @override
  final String userNameLanguageCode;
  @override
  final double userNameNagativeScore;
  @override
  final double userNamePositiveScore;
  @override
  final String userNameSentiment;
  @override
  final String userImageURL;
  @override
  final String uid;
  @override
  final dynamic updatedAt;

  @override
  String toString() {
    return 'FirestoreUser(createdAt: $createdAt, followerCount: $followerCount, followingCount: $followingCount, isAdmin: $isAdmin, muteCount: $muteCount, searchToken: $searchToken, postCount: $postCount, userName: $userName, userNameLanguageCode: $userNameLanguageCode, userNameNagativeScore: $userNameNagativeScore, userNamePositiveScore: $userNamePositiveScore, userNameSentiment: $userNameSentiment, userImageURL: $userImageURL, uid: $uid, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirestoreUser &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.muteCount, muteCount) ||
                other.muteCount == muteCount) &&
            const DeepCollectionEquality()
                .equals(other._searchToken, _searchToken) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userNameLanguageCode, userNameLanguageCode) ||
                other.userNameLanguageCode == userNameLanguageCode) &&
            (identical(other.userNameNagativeScore, userNameNagativeScore) ||
                other.userNameNagativeScore == userNameNagativeScore) &&
            (identical(other.userNamePositiveScore, userNamePositiveScore) ||
                other.userNamePositiveScore == userNamePositiveScore) &&
            (identical(other.userNameSentiment, userNameSentiment) ||
                other.userNameSentiment == userNameSentiment) &&
            (identical(other.userImageURL, userImageURL) ||
                other.userImageURL == userImageURL) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(createdAt),
      followerCount,
      followingCount,
      isAdmin,
      muteCount,
      const DeepCollectionEquality().hash(_searchToken),
      postCount,
      userName,
      userNameLanguageCode,
      userNameNagativeScore,
      userNamePositiveScore,
      userNameSentiment,
      userImageURL,
      uid,
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirestoreUserCopyWith<_$_FirestoreUser> get copyWith =>
      __$$_FirestoreUserCopyWithImpl<_$_FirestoreUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirestoreUserToJson(
      this,
    );
  }
}

abstract class _FirestoreUser implements FirestoreUser {
  const factory _FirestoreUser(
      {required final dynamic createdAt,
      required final int followerCount,
      required final int followingCount,
      required final bool isAdmin,
      required final int muteCount,
      required final Map<String, dynamic> searchToken,
      required final int postCount,
      required final String userName,
      required final String userNameLanguageCode,
      required final double userNameNagativeScore,
      required final double userNamePositiveScore,
      required final String userNameSentiment,
      required final String userImageURL,
      required final String uid,
      required final dynamic updatedAt}) = _$_FirestoreUser;

  factory _FirestoreUser.fromJson(Map<String, dynamic> json) =
      _$_FirestoreUser.fromJson;

  @override
  dynamic get createdAt;
  @override
  int get followerCount;
  @override
  int get followingCount;
  @override
  bool get isAdmin;
  @override
  int get muteCount;
  @override
  Map<String, dynamic> get searchToken;
  @override
  int get postCount;
  @override
  String get userName;
  @override
  String get userNameLanguageCode;
  @override
  double get userNameNagativeScore;
  @override
  double get userNamePositiveScore;
  @override
  String get userNameSentiment;
  @override
  String get userImageURL;
  @override
  String get uid;
  @override
  dynamic get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_FirestoreUserCopyWith<_$_FirestoreUser> get copyWith =>
      throw _privateConstructorUsedError;
}
