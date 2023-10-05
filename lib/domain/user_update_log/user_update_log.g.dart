// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserUpdateLogImpl _$$UserUpdateLogImplFromJson(Map<String, dynamic> json) =>
    _$UserUpdateLogImpl(
      logCreatedAt: json['logCreatedAt'],
      userName: json['userName'] as String,
      searchToken: json['searchToken'] as Map<String, dynamic>,
      userImageURL: json['userImageURL'] as String,
      userRef: json['userRef'],
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$$UserUpdateLogImplToJson(_$UserUpdateLogImpl instance) =>
    <String, dynamic>{
      'logCreatedAt': instance.logCreatedAt,
      'userName': instance.userName,
      'searchToken': instance.searchToken,
      'userImageURL': instance.userImageURL,
      'userRef': instance.userRef,
      'uid': instance.uid,
    };
