// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) => TaskResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : TaskData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskResponseToJson(TaskResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

TaskData _$TaskDataFromJson(Map<String, dynamic> json) => TaskData(
      json['taskName'] as String?,
      json['startLocation'] as String?,
      json['destination'] as String?,
      json['wheelChair'] as bool?,
      json['scheduleDate'] as String?,
      json['_id'] as int?,
      json['taskStatus'] == null
          ? null
          : TaskStatus.fromJson(json['taskStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskDataToJson(TaskData instance) => <String, dynamic>{
      '_id': instance.taskId,
      'taskName': instance.taskName,
      'startLocation': instance.startLocation,
      'destination': instance.destination,
      'wheelChair': instance.wheelChair,
      'scheduleDate': instance.scheduleDate,
      'taskStatus': instance.taskStatus,
    };

TaskStatus _$TaskStatusFromJson(Map<String, dynamic> json) => TaskStatus(
      json['taskId'] as int?,
      json['taskStatus'] as String?,
      json['assignedTo'] as String?,
    );

Map<String, dynamic> _$TaskStatusToJson(TaskStatus instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'taskStatus': instance.taskStatus,
      'assignedTo': instance.assignedTo,
    };
