// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoneData _$ZoneDataFromJson(Map<String, dynamic> json) => ZoneData(
      (json['wallDevice'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, WallDevice.fromJson(e as Map<String, dynamic>)),
      ),
      json['current_time'] as int?,
    );

Map<String, dynamic> _$ZoneDataToJson(ZoneData instance) => <String, dynamic>{
      'wallDevice': instance.wallDevice,
      'current_time': instance.currentTime,
    };

WallDevice _$WallDeviceFromJson(Map<String, dynamic> json) => WallDevice(
      (json['beacons'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, TimeList.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$WallDeviceToJson(WallDevice instance) =>
    <String, dynamic>{
      'beacons': instance.beacons,
    };

TimeList _$TimeListFromJson(Map<String, dynamic> json) => TimeList(
      (json['tags'] as List<dynamic>?)
          ?.map((e) => TagData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimeListToJson(TimeList instance) => <String, dynamic>{
      'tags': instance.tags,
    };

TagData _$TagDataFromJson(Map<String, dynamic> json) => TagData(
      json['data_format'] as int?,
      json['measurement_sequence_number'] as int?,
      json['movement_counter'] as int?,
      (json['humidity'] as num?)?.toDouble(),
      json['acceleration_x'] as int?,
      json['rssi'] as int?,
      (json['temperature'] as num).toDouble(),
      json['acceleration_y'] as int?,
      json['acceleration_z'] as int?,
      json['timestamp'] as int?,
      (json['pressure'] as num?)?.toDouble(),
      (json['acceleration'] as num?)?.toDouble(),
      (json['battery'] as num?)?.toDouble(),
      json['mac'] as String?,
      json['tx_power'] as int?,
      json['zone_id'] as int?,
      json['visible'] as bool?,
      json['beacon_type'] as String?,
      json['department'] as String?,
      json['name'] as String?,
      json['zone_direction'] as String?,
      json['gender'] as String?,
      json['wall_device_id'] as String?,
      json['wall_device_type'] as String?,
      json['shift_id'] as String?,
      json['allocated_floor'] as String?,
      json['floor'] as String?,
      json['UUID'] as String?,
      json['beacon_address'] as String?,
      json['log_time_stamp'] as String?,
    );

Map<String, dynamic> _$TagDataToJson(TagData instance) => <String, dynamic>{
      'data_format': instance.dataFormat,
      'measurement_sequence_number': instance.measuermentSequenceNumber,
      'movement_counter': instance.movementCounter,
      'humidity': instance.humidity,
      'acceleration_x': instance.accelerationX,
      'rssi': instance.rssi,
      'temperature': instance.temperature,
      'acceleration_y': instance.accelerationY,
      'acceleration_z': instance.accelerationZ,
      'timestamp': instance.timestamp,
      'pressure': instance.pressure,
      'acceleration': instance.acceleration,
      'battery': instance.battery,
      'mac': instance.mac,
      'tx_power': instance.txPower,
      'zone_id': instance.zoneId,
      'visible': instance.visible,
      'beacon_type': instance.beaconType,
      'department': instance.department,
      'name': instance.name,
      'zone_direction': instance.zoneDirection,
      'gender': instance.gender,
      'wall_device_id': instance.wallDeviceId,
      'wall_device_type': instance.wallDeviceType,
      'shift_id': instance.shiftID,
      'allocated_floor': instance.allocatedFloor,
      'floor': instance.floor,
      'UUID': instance.uuid,
      'beacon_address': instance.beaconAddress,
      'log_time_stamp': instance.logTimeStamp,
    };
