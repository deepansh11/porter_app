import 'package:json_annotation/json_annotation.dart';

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
