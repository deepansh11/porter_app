import 'package:json_annotation/json_annotation.dart';

part 'zone_data.g.dart';

@JsonSerializable()
class ZoneData {
  @JsonKey(name: 'wallDevice')
  final Map<String, WallDevice>? wallDevice;

  @JsonKey(name: 'current_time')
  final int? currentTime;

  ZoneData(this.wallDevice, this.currentTime);

  factory ZoneData.fromJson(Map<String, dynamic> json) =>
      _$ZoneDataFromJson(json);
  Map<String, dynamic> toJson() => _$ZoneDataToJson(this);
}

@JsonSerializable()
class WallDevice {
  final Map<String, TimeList>? beacons;

  WallDevice(this.beacons);

  factory WallDevice.fromJson(Map<String, dynamic> json) =>
      _$WallDeviceFromJson(json);
  Map<String, dynamic> toJson() => _$WallDeviceToJson(this);
}

@JsonSerializable()
class TimeList {
  final List<TagData>? tags;

  TimeList(this.tags);

  factory TimeList.fromJson(Map<String, dynamic> json) =>
      _$TimeListFromJson(json);
  Map<String, dynamic> toJson() => _$TimeListToJson(this);
}

@JsonSerializable()
class TagData {
  @JsonKey(name: 'data_format')
  final int? dataFormat;
  @JsonKey(name: 'measurement_sequence_number')
  final int? measuermentSequenceNumber;
  @JsonKey(name: 'movement_counter')
  final int? movementCounter;

  final double? humidity;
  @JsonKey(name: 'acceleration_x')
  final int? accelerationX;

  final int? rssi;
  final double temperature;

  @JsonKey(name: 'acceleration_y')
  final int? accelerationY;

  @JsonKey(name: 'acceleration_z')
  final int? accelerationZ;
  final int? timestamp;
  final double? pressure;
  final double? acceleration;
  final double? battery;
  final String? mac;

  @JsonKey(name: 'tx_power')
  final int? txPower;
  @JsonKey(name: 'zone_id')
  final int? zoneId;
  final bool? visible;
  @JsonKey(name: 'beacon_type')
  final String? beaconType;
  final String? department;
  final String? name;
  @JsonKey(name: 'zone_direction')
  final String? zoneDirection;
  final String? gender;
  @JsonKey(name: 'wall_device_id')
  final String? wallDeviceId;
  @JsonKey(name: 'wall_device_type')
  final String? wallDeviceType;
  @JsonKey(name: 'shift_id')
  final String? shiftID;
  @JsonKey(name: 'allocated_floor')
  final String? allocatedFloor;
  final String? floor;
  @JsonKey(name: 'UUID')
  final String? uuid;
  @JsonKey(name: 'beacon_address')
  final String? beaconAddress;
  @JsonKey(name: 'log_time_stamp')
  final String? logTimeStamp;

  TagData(
      this.dataFormat,
      this.measuermentSequenceNumber,
      this.movementCounter,
      this.humidity,
      this.accelerationX,
      this.rssi,
      this.temperature,
      this.accelerationY,
      this.accelerationZ,
      this.timestamp,
      this.pressure,
      this.acceleration,
      this.battery,
      this.mac,
      this.txPower,
      this.zoneId,
      this.visible,
      this.beaconType,
      this.department,
      this.name,
      this.zoneDirection,
      this.gender,
      this.wallDeviceId,
      this.wallDeviceType,
      this.shiftID,
      this.allocatedFloor,
      this.floor,
      this.uuid,
      this.beaconAddress,
      this.logTimeStamp);

  factory TagData.fromJson(Map<String, dynamic> json) =>
      _$TagDataFromJson(json);
  Map<String, dynamic> toJson() => _$TagDataToJson(this);
}
