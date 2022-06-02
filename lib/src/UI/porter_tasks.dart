import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:porter_app/src/UI/widgets/app_button.dart';

import '../data/zone_data.dart';
import '../repo/providers.dart';

class PorterTasks extends ConsumerStatefulWidget {
  const PorterTasks({Key? key}) : super(key: key);

  @override
  ConsumerState<PorterTasks> createState() => _PorterTasksState();
}

class _PorterTasksState extends ConsumerState<PorterTasks> {
  @override
  Widget build(BuildContext context) {
    ZoneData? zoneData;
    final zone = ref.watch(mqttMessage.notifier);
    final data = zone.returnZone();
    if (data.isNotEmpty) {
      final Map<String, dynamic>? showZones = jsonDecode(data.toString());
      if (showZones != null) {
        zoneData = ZoneData.fromJson(showZones);
      }
    }

    final date =
        DateTime.fromMillisecondsSinceEpoch(zoneData?.currentTime ?? 0);

    final currentTime = DateFormat.yMd().add_Hms().format(date);

    return Column(children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'Porter Profile',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Current Time: $currentTime'),
      ),
      AppButton(
        onPressed: () {},
        label: 'On Break',
        icon: Icons.location_off,
      )
    ]);
  }
}
