import 'package:json_annotation/json_annotation.dart';

part 'tasks.g.dart';

@JsonSerializable()
class TaskResponse {
  final List<TaskData?>? data;

  TaskResponse(this.data);

  factory TaskResponse.fromJson(List<dynamic> json) {
    List<TaskData> taskData = <TaskData>[];
    taskData = json.map((e) => TaskData.fromJson(e)).toList();

    return TaskResponse(taskData);
  }
}

@JsonSerializable()
class TaskDataForNotif {
  @JsonKey(name: '_id')
  final int? taskId;
  final String? taskName;
  final String? startLocation;
  final String? destination;
  final bool? wheelChair;
  final String? scheduleDate;
  final String? priority;
  final String? wheelChairType;
  final String? taskStatus;

  TaskDataForNotif(
    this.taskName,
    this.startLocation,
    this.destination,
    this.wheelChair,
    this.scheduleDate,
    this.taskId,
    this.taskStatus,
    this.priority,
    this.wheelChairType,
  );

  factory TaskDataForNotif.fromJson(Map<String, dynamic> json) =>
      _$TaskDataForNotifFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDataForNotifToJson(this);
}

@JsonSerializable()
class TaskData {
  @JsonKey(name: '_id')
  final int? taskId;
  final String? taskName;
  final String? startLocation;
  final String? destination;
  final bool? wheelChair;
  final String? scheduleDate;
  final String? priority;
  final String? wheelChairType;
  final TaskStatus? taskStatus;

  TaskData(
    this.taskName,
    this.startLocation,
    this.destination,
    this.wheelChair,
    this.scheduleDate,
    this.taskId,
    this.taskStatus,
    this.priority,
    this.wheelChairType,
  );

  factory TaskData.fromJson(Map<String, dynamic> json) =>
      _$TaskDataFromJson(json);
  Map<String, dynamic> toJson() => _$TaskDataToJson(this);
}

@JsonSerializable()
class TaskStatus {
  final int? taskId;
  final String? taskStatus;
  final String? assignedTo;

  TaskStatus(
    this.taskId,
    this.taskStatus,
    this.assignedTo,
  );

  factory TaskStatus.fromJson(Map<String, dynamic> json) =>
      _$TaskStatusFromJson(json);
  Map<String, dynamic> toJson() => _$TaskStatusToJson(this);
}
