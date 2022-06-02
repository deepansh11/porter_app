import 'package:json_annotation/json_annotation.dart';
import 'package:porter_app/src/data/tasks.dart';

part 'porter.g.dart';

@JsonSerializable()
class Porter {
  @JsonKey(name: 'porterUserName')
  final String? userName;
  @JsonKey(name: 'porterPassword')
  final String? password;

  Porter(
    this.userName,
    this.password,
  );

  factory Porter.fromJson(Map<String, dynamic> json) => _$PorterFromJson(json);
  Map<String, dynamic> toJson() => _$PorterToJson(this);
}

class NotifPayload {
  final TaskDataForNotif data;
  final Porter porter;

  NotifPayload(this.data, this.porter);
}

class DataPayload {
  final TaskData data;
  final Porter porter;

  DataPayload(this.data, this.porter);
}
