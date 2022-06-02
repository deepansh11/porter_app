import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porter_app/src/UI/home_screen.dart';
import 'package:porter_app/src/UI/widgets/app_button.dart';
import 'package:porter_app/src/UI/widgets/wheel_chair_location.dart';
import 'package:porter_app/src/data/tasks.dart';
import 'package:porter_app/src/repo/providers.dart';
import 'package:porter_app/src/repo/tasks.dart';

import '../data/porter.dart';
import '../data/zone_data.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  static const routeName = '/taskInfo';

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  bool didButtonPress = false;
  late MqttPayload mqtt;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    mqtt = ref.watch(mqttMessage.notifier);
  }

  _showDelayAndChangeButtonText(TaskPayload payload) {
    setState(() {
      didButtonPress = !didButtonPress;
    });

    Future.delayed(
      const Duration(milliseconds: 20),
      () async {
        await ref.watch(taskUpdateProvider(payload).future);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Sending arrive time to server',
            ),
          ),
        );
      },
    );
  }

  void _endTask(Porter porter, TaskPayload payload) async {
    await ref.watch(taskUpdateProvider(payload).future);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Are you sure you want to end the task?'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(HomeScreen.routeName, arguments: porter);
                },
                child: const Text('OK'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DataPayload arguments =
        ModalRoute.of(context)?.settings.arguments as DataPayload;
    final taskData = arguments.data;

    ZoneData? zoneData;
    final zone = ref.watch(mqttMessage.notifier);
    final data = zone.returnZone();
    if (data.isNotEmpty) {
      final Map<String, dynamic>? showZones = jsonDecode(data.toString());
      if (showZones != null) {
        zoneData = ZoneData.fromJson(showZones);
      }
    }

    final newTaskData = TaskData(
      taskData.taskName,
      taskData.startLocation,
      taskData.destination,
      taskData.wheelChair,
      taskData.scheduleDate,
      taskData.taskId,
      TaskStatus(4, 'Arrived', arguments.porter.userName),
      taskData.priority,
      taskData.wheelChairType,
    );

    final newTaskEndData = TaskData(
      taskData.taskName,
      taskData.startLocation,
      taskData.destination,
      taskData.wheelChair,
      taskData.scheduleDate,
      taskData.taskId,
      TaskStatus(5, 'Task Ended', arguments.porter.userName),
      taskData.priority,
      taskData.wheelChairType,
    );

    final wallDeviceMac = zoneData?.wallDevice?.keys.first ?? '';
    // print('Values: ${zoneData?.wallDevice?.entries}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Info'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/map.jpeg'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'TaskName: ${taskData.taskName}',
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'End location: ${taskData.destination}',
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Start location: ${taskData.startLocation}',
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Is Wheel chair required? ${taskData.wheelChair}',
            ),
            const SizedBox(
              height: 10,
            ),
            // Text(
            //   'Wheel Chair Type: ${taskData.wheelChair}',
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                      child: Container(
                    child: const Text('Wheel Chair Location:'),
                    transform: Matrix4.translationValues(0, -3, 0),
                    margin: const EdgeInsets.only(bottom: 12),
                  )),
                  WidgetSpan(
                      child: TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const WheelChairDialog();
                                });
                          },
                          child: Text(
                            wallDeviceMac,
                            style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                          )))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            !didButtonPress
                ? AppButton(
                    onPressed: () {
                      _showDelayAndChangeButtonText(TaskPayload(
                        taskData.taskId ?? 0,
                        newTaskData,
                      ));
                    },
                    label: 'Arrived',
                    icon: Icons.access_time,
                  )
                : const SizedBox(),
            didButtonPress
                ? AppButton(
                    onPressed: () => _endTask(
                        arguments.porter,
                        TaskPayload(
                          taskData.taskId ?? 0,
                          newTaskEndData,
                        )),
                    label: 'End Task',
                    icon: Icons.done,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
