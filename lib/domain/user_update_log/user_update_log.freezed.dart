// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_update_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserUpdateLog _$UserUpdateLogFromJson(Map<String, dynamic> json) {
  return _UserUpdateLog.fromJson(json);
}

/// @nodoc
mixin _$UserUpdateLog {
// 順番がわからなくなるので妥協してupdateAtは入れる。
// userのupdateには使用させない
  dynamic get logCreatedAt => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  Map<String, dynamic> get searchToken => throw _privateConstructorUsedError;
  String get userImageURL => throw _privateConstructorUsedError;
  dynamic get userRef => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserUpdateLogCopyWith<UserUpdateLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserUpdateLogCopyWith<$Res> {
  factory $UserUpdateLogCopyWith(
          UserUpdateLog value, $Res Function(UserUpdateLog) then) =
      _$UserUpdateLogCopyWithImpl<$Res, UserUpdateLog>;
  @useResult
  $Res call(
      {dynamic logCreatedAt,
      String userName,
      Map<String, dynamic> searchToken,
      String userImageURL,
      dynamic userRef,
      String uid});
}

/// @nodoc
class _$UserUpdateLogCopyWithImpl<$Res, $Val extends UserUpdateLog>
    implements $UserUpdateLogCopyWith<$Res> {
  _$UserUpdateLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logCreatedAt = freezed,
    Object? userName = null,
    Object? searchToken = null,
    Object? userImageURL = null,
    Object? userRef = freezed,
    Object? uid = null,
  }) {
    return _then(_value.copyWith(
      logCreatedAt: freezed == logCreatedAt
          ? _value.logCreatedAt
          : logCreatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      searchToken: null == searchToken
          ? _value.searchToken
          : searchToken // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      userRef: freezed == userRef
          ? _value.userRef
          : userRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserUpdateLogCopyWith<$Res>
    implements $UserUpdateLogCopyWith<$Res> {
  factory _$$_UserUpdateLogCopyWith(
          _$_UserUpdateLog value, $Res Function(_$_UserUpdateLog) then) =
      __$$_UserUpdateLogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic logCreatedAt,
      String userName,
      Map<String, dynamic> searchToken,
      String userImageURL,
      dynamic userRef,
      String uid});
}

/// @nodoc
class __$$_UserUpdateLogCopyWithImpl<$Res>
    extends _$UserUpdateLogCopyWithImpl<$Res, _$_UserUpdateLog>
    implements _$$_UserUpdateLogCopyWith<$Res> {
  __$$_UserUpdateLogCopyWithImpl(
      _$_UserUpdateLog _value, $Res Function(_$_UserUpdateLog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logCreatedAt = freezed,
    Object? userName = null,
    Object? searchToken = null,
    Object? userImageURL = null,
    Object? userRef = freezed,
    Object? uid = null,
  }) {
    return _then(_$_UserUpdateLog(
      logCreatedAt: freezed == logCreatedAt
          ? _value.logCreatedAt
          : logCreatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      searchToken: null == searchToken
          ? _value._searchToken
          : searchToken // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      userRef: freezed == userRef
          ? _value.userRef
          : userRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserUpdateLog implements _UserUpdateLog {
  const _$_UserUpdateLog(
      {required this.logCreatedAt,
      required this.userName,
      required final Map<String, dynamic> searchToken,
      required this.userImageURL,
      required this.userRef,
      required this.uid})
      : _searchToken = searchToken;

  factory _$_UserUpdateLog.fromJson(Map<String, dynamic> json) =>
      _$$_UserUpdateLogFromJson(json);

// 順番がわからなくなるので妥協してupdateAtは入れる。
// userのupdateには使用させない
  @override
  final dynamic logCreatedAt;
  @override
  final String userName;
  final Map<String, dynamic> _searchToken;
  @override
  Map<String, dynamic> get searchToken {
    if (_searchToken is EqualUnmodifiableMapView) return _searchToken;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_searchToken);
  }

  @override
  final String userImageURL;
  @override
  final dynamic userRef;
  @override
  final String uid;

  @override
  String toString() {
    return 'UserUpdateLog(logCreatedAt: $logCreatedAt, userName: $userName, searchToken: $searchToken, userImageURL: $userImageURL, userRef: $userRef, uid: $uid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserUpdateLog &&
            const DeepCollectionEquality()
                .equals(other.logCreatedAt, logCreatedAt) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            const DeepCollectionEquality()
                .equals(other._searchToken, _searchToken) &&
            (identical(other.userImageURL, userImageURL) ||
                other.userImageURL == userImageURL) &&
            const DeepCollectionEquality().equals(other.userRef, userRef) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(logCreatedAt),
      userName,
      const DeepCollectionEquality().hash(_searchToken),
      userImageURL,
      const DeepCollectionEquality().hash(userRef),
      uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserUpdateLogCopyWith<_$_UserUpdateLog> get copyWith =>
      __$$_UserUpdateLogCopyWithImpl<_$_UserUpdateLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserUpdateLogToJson(
      this,
    );
  }
}

abstract class _UserUpdateLog implements UserUpdateLog {
  const factory _UserUpdateLog(
      {required final dynamic logCreatedAt,
      required final String userName,
      required final Map<String, dynamic> searchToken,
      required final String userImageURL,
      required final dynamic userRef,
      required final String uid}) = _$_UserUpdateLog;

  factory _UserUpdateLog.fromJson(Map<String, dynamic> json) =
      _$_UserUpdateLog.fromJson;

  @override // 順番がわからなくなるので妥協してupdateAtは入れる。
// userのupdateには使用させない
  dynamic get logCreatedAt;
  @override
  String get userName;
  @override
  Map<String, dynamic> get searchToken;
  @override
  String get userImageURL;
  @override
  dynamic get userRef;
  @override
  String get uid;
  @override
  @JsonKey(ignore: true)
  _$$_UserUpdateLogCopyWith<_$_UserUpdateLog> get copyWith =>
      throw _privateConstructorUsedError;
}
