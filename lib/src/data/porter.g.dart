// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'porter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Porter _$PorterFromJson(Map<String, dynamic> json) => Porter(
      json['porterUserName'] as String?,
      json['porterPassword'] as String?,
    );

Map<String, dynamic> _$PorterToJson(Porter instance) => <String, dynamic>{
      'porterUserName': instance.userName,
      'porterPassword': instance.password,
    };
